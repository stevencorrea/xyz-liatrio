terraform {
  backend "remote" {
    # The name of your Terraform Cloud organization
    organization = "xyz-liatrio"

    # The name of the Terraform Cloud Workspace
    workspaces {
      name = "xyz-liatrio-azure"
    }
  }
  # Use newest Azure provider at this time
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.44.1"
    }
  }
}

# Invoke Azure
provider "azurerm" {
  features {}
}

# Create a resource group for the AKS cluster and ACR
resource "azurerm_resource_group" "xyz-prod" {
  name     = "xyz-prod"
  location = "westus"
}

# Create our ACR
resource "azurerm_container_registry" "xyz-acr" {
  name                     = "xyz-acr"
  resource_group_name      = azurerm_resource_group.xyz-prod.name
  location                 = azurerm_resource_group.xyz-prod.location
  sku                      = "Basic"
  admin_enabled            = false
  georeplication_locations = ["westus"]
}

# Create our AKS cluster
resource "azurerm_kubernetes_cluster" "xyz-aks-cluster" {
  name                = "xyz-aks-cluster"
  location            = azurerm_resource_group.xyz-prod.location
  resource_group_name = azurerm_resource_group.xyz-prod.name
  dns_prefix          = "xyz-aks-cluster"

  default_node_pool {
    name            = "default"
    node_count      = 3
    vm_size         = "Standard_D2_v2"
    type            = "VirtualMachineScaleSets"
  }
  # We don't really care about the nodes, just need a cluster
  identity {
    type = "SystemAssigned"
  }
}

# Attach our ACR to the AKS cluster via SP
# Only give our sp the built in AcrPull role
# az role definition list --name AcrPull
# https://learn.microsoft.com/en-us/azure/role-based-access-control/role-definitions-list
resource "azurerm_kubernetes_service_principal" "acr-aks-sp" {
  role_definition_name = "AcrPull"
  role_definition_id   = "/subscriptions/b9009040-4a5e-47c8-833e-44bdbe7d3423/providers/Microsoft.Authorization/roleDefinitions/7f951dda-4ed3-4680-a7ca-43fe172d538d"

  depends_on = [azurerm_container_registry.xyz-acr]

  service_principal_id = azurerm_kubernetes_cluster.xyz-aks-cluster.identity[0].principal_id
  client_id            = azurerm_container_registry.xyz-acr.login_server
}

resource "azurerm_role_assignment" "acr-aks-sp-role" {
  scope                = azurerm_container_registry.xyz-acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.xyz-aks-cluster.identity[0].principal_id
}

# Output kconfig
output "kube_config" {
  value = azurerm_kubernetes_cluster.xyz-aks-cluster.kube_config_raw
}
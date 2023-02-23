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

# Invoke AzureRM
provider "azurerm" {
  features {}
}

# resource "null_resource" "is-the-rube-machine-turing-complete" {
# }


# Create a resource group for the AKS cluster and ACR
resource "azurerm_resource_group" "xyz-liatrio" {
  name     = "xyz-liatrio"
  location = "westus"
}

# Create our ACR
resource "azurerm_container_registry" "xyzacrliatrio" {
  name                = "xyzacrliatrio"
  resource_group_name = azurerm_resource_group.xyz-liatrio.name
  location            = azurerm_resource_group.xyz-liatrio.location
  sku                 = "Basic"
  admin_enabled       = false
}

# Create our AKS cluster
resource "azurerm_kubernetes_cluster" "xyz-aks-cluster" {
  name                = "xyz-aks-cluster"
  location            = azurerm_resource_group.xyz-liatrio.location
  resource_group_name = azurerm_resource_group.xyz-liatrio.name
  dns_prefix          = "xyz-aks-cluster"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_D2_v2"
    type       = "VirtualMachineScaleSets"
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
# resource "azurerm_azuread_service_principal" "aks-sp" {
#   application_id = "42e9ad34-859c-4518-a56e-34cc276356f5"
# }

# resource "azurerm_serv" "name" {
  
# }

# resource "azurerm_role_assignment" "acr-aks-sp-role" {
#   scope                = azurerm_container_registry.xyzacrliatrio.id
#   role_definition_name = "AcrPull"
#   principal_id         = azurerm_kubernetes_cluster.xyz-aks-cluster.identity[0].principal_id
# }

# Output kconfig
output "kube_config" {
  value = azurerm_kubernetes_cluster.xyz-aks-cluster.kube_config_raw
}
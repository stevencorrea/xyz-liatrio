terraform {
  backend "remote" {
    # The name of our Terraform Cloud organization
    organization = "xyz-liatrio"

    # The name of our Terraform Cloud Workspace
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
  skip_provider_registration = true
}

# Delete this to trigger a run!
# resource "null_resource" "is-the-rube-machine-turing-complete" {
# }

 #Imported resource
 resource "azurerm_resource_group" "xyz-liatrio" {
   name     = "xyz-liatrio"
   location = "westus"
}

# Create our ACR
resource "azurerm_container_registry" "xyzacrliatrio" {
  name                = "xyzacrliatrio"
  location            = azurerm_resource_group.xyz-liatrio.location
  resource_group_name = azurerm_resource_group.xyz-liatrio.name
  sku                 = "Basic"
  admin_enabled       = true
}

# Create our AKS cluster
resource "azurerm_kubernetes_cluster" "xyz-aks-cluster" {
  name                = "xyz-aks-cluster"
  location            = azurerm_resource_group.xyz-liatrio.location
  resource_group_name = azurerm_resource_group.xyz-liatrio.name
  dns_prefix          = "xyz-aks-cluster"
  # Enable http routing for ingress controller
  http_application_routing_enabled = true

  # Make our node pool Linux based
  default_node_pool {
    name                = "default"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 5
    os_sku              = "Ubuntu"
    vm_size             = "Standard_D2_v2"
    type                = "VirtualMachineScaleSets"
  }
  # Let Azure manage identity for the cluster
  identity {
    type = "SystemAssigned"
  }
}

# Service Principal generated for the AKS cluster to pull ACR images
resource "azurerm_role_assignment" "aks-acr-role" {
  scope                = azurerm_container_registry.xyzacrliatrio.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.xyz-aks-cluster.kubelet_identity[0].object_id
}
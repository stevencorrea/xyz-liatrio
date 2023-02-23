terraform {
  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "xyz-liatrio"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "xyz-liatrio-azure"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.44.1"
    }
  }
}

provider "azurerm" {
  features {}
}

# An example resource that does nothing.
resource "null_resource" "example" {
  triggers = {
    value = "A example resource that does nothing!"
  }
}

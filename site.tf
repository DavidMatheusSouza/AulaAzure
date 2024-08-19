# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0" # Optional but recommended in production
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
# Create Resource Group 
resource "azurerm_resource_group" "aula02" {
  location = "westeurope"
  name     = "auladevops02"
  tags = merge(var.tags, {
    "workspace" = "${terraform.workspace}"
    }
  )
}

resource "azurerm_storage_account" "aula02" {
  name                      = "devops02"
  resource_group_name       = azurerm_resource_group.aula02.name
  location                  = azurerm_resource_group.aula02.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true

  static_website {
    index_document = "index.html"
  }

  tags = merge(var.tags, {
    "workspace" = "${terraform.workspace}"
    }
  )
}

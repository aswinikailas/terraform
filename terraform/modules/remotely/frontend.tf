terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "RemotelyRG" {
  name     = "RemotelyRG_${var.environment}"
  location = "East US"
}

#Create Storage Account
resource "azurerm_storage_account" "RemotelySA" {
    name = "remotelyfesa${var.environment}"
    resource_group_name = azurerm_resource_group.RemotelyRG.name
    location = azurerm_resource_group.RemotelyRG.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    account_kind = "StorageV2"
    enable_https_traffic_only = true
    static_website {
      index_document="index.html"
    }
    tags = {
        environment="${var.environment}"
    }
  
}

resource "azurerm_cdn_profile" "RemotelyCDNProfile" {
  name                = "remotelyCDN${var.environment}"
  location            = azurerm_resource_group.RemotelyRG.location
  resource_group_name = azurerm_resource_group.RemotelyRG.name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "RemotelyCDNEndpoint" {
  name                = "RemotelyCDNEndpoint${var.environment}"
  profile_name        = azurerm_cdn_profile.RemotelyCDNProfile.name
  location            =azurerm_resource_group.RemotelyRG.location
  resource_group_name = azurerm_resource_group.RemotelyRG.name

  origin {
    name      = "RemotelyRnDDev"
    host_name = azurerm_storage_account.RemotelySA.primary_web_host
  }
}


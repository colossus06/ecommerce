terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_string" "rnd" {
  length  = 5
  special = false
  upper   = false
}
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = var.resource_group_name
}

resource "azurerm_storage_account" "sa" {
  #we need a unique storage account name
  name                     = "${var.sa_name}${random_string.rnd.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false
  min_tls_version= "TLS1_2"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "sc" {
  name                  = var.sc_name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
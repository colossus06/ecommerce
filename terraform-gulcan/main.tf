terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.94.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "random_string" "rnd" {
  length  = 5
  special = false
  upper   = false
}
resource "azurerm_resource_group" "rg-hub" {
  location = var.rg-hub-location
  name     = var.rg-hub
}

resource "azurerm_resource_group" "rg-spoke1" {
  location = var.rg-spoke1-location
  name     = var.rg-spoke1
}

# resource "azurerm_resource_group" "rg-spoke2" {
#   location = var.rg-spoke2-location
#   name     = var.rg-spoke2
# }

resource "azurerm_kubernetes_cluster" "hub" {
  name                = var.aks_hub_cluster_name
  location            = azurerm_resource_group.rg-hub.location
  resource_group_name = azurerm_resource_group.rg-hub.name
  dns_prefix          = "gtazuredevops"
  sku_tier= "Free"

#compute resources
  default_node_pool {
    enable_auto_scaling= true
    name       = "default"
    min_count = 1
    max_count = 2
    node_count = 1
    max_pods = 30
    enable_node_public_ip= true
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Stage"
  }
}

resource "azurerm_kubernetes_cluster" "spoke1" {
  name                = var.aks_spoke1_cluster_name
  location            = azurerm_resource_group.rg-spoke1.location
  resource_group_name = azurerm_resource_group.rg-spoke1.name
  dns_prefix          = "gtazuredevopsspoke"
  sku_tier= "Free"

#compute resources
  default_node_pool {
    enable_auto_scaling= true
    name       = "default"
    min_count = 1
    max_count = 2
    node_count = 1
    max_pods = 30
    enable_node_public_ip= false
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Stage"
  }
}

# resource "azurerm_kubernetes_cluster" "spoke2" {
#   name                = var.aks_spoke2_cluster_name
#   location            = azurerm_resource_group.rg-spoke2.location
#   resource_group_name = azurerm_resource_group.rg-spoke2.name
#   dns_prefix          = "gtazuredevopsspokee"
#   sku_tier= "Free"

# #compute resources
#   default_node_pool {
#     enable_auto_scaling= true
#     name       = "default"
#     min_count = 1
#     max_count = 2
#     node_count = 1
#     max_pods = 30
#     enable_node_public_ip= false
#     vm_size    = "Standard_D2_v2"
#   }

#   identity {
#     type = "SystemAssigned"
#   }

#   tags = {
#     Environment = "Stage"
#   }
# }


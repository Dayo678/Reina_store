terraform {
  # 1. Required Version Terraform
  required_version = ">= 0.13"
  # 2. Required Terraform Providers  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }
# Terraform State Storage to Azure Storage Container
  backend "azurerm" {
    #resource_group_name   = "terraform-storage-rg"
    #storage_account_name  = "terraformstatexlrwdrzs"
    #container_name        = "tfstatefiles"
    #key                   = "terraform-custom-vnet.tfstate"
  }  
}
# 2. Terraform Provider Block for AzureRM
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "ask-rcg-name" {
  name     = var.resource_group_name
  location = var.location
}

data "azurerm_kubernetes_service_versions" "current" {
  location = var.location
}

resource "azurerm_virtual_network" "aks-vent" {
  name                = "cluster-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/8"]

  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "aks-vnet-subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks-vent.name
  address_space     = ["10.0.1.0/16"]
}

resource "azurerm_kubernetes_cluster" "aks-react" {

  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.resource_group_name
  kubernetes_version = data.azurerm_kubernetes_service_versions.current.latest_version


  default_node_pool {
    name       = var.default_node
    vnet_subnet_id = azurerm_subnet.aks-vnet-subnet.id
    node_count = 1
    min_count = 1
    max_count = 5
    zones = [1, 2]
    vm_size    = "Standard_D2_v2"
    enable_auto_scaling = true
    type = var.default_node_type
    node_labels = {
      "nodepool-type" = var.default_node_label
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "Standard"
  }
  
  tags = {
    Environment = "Production"
  }
}
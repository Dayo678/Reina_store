resource "azurerm_virtual_network" "aks-vent" {
  name                = "${azurerm_kubernetes_cluster.aks-react.name}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "aks-vnet-subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks-vent.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_resource_group" "ask-rcg-name" {
  name     = var.resource_group_name
  location = var.location
}


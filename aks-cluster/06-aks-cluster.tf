
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

  tags = {
    Environment = "Production"
  }
}
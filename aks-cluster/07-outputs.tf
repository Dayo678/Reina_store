output "cluster_name" {
    value = azurerm_kubernetes_cluster.aks-react.name
}

output "resource_group" {
  value = azurerm_resource_group.ask-rcg-name.name
}

output "k8s_verion" {
  value = data.azurerm_kubernetes_service_versions.current.latest_version
}
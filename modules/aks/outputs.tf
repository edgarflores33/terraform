output cluster_id {
  value = azurerm_kubernetes_cluster.clusteraks.id
}

output cluster {
  value = {
    location     = var.rsgr_loc,
    cluster      = azurerm_kubernetes_cluster.clusteraks
    principal_id = azurerm_kubernetes_cluster.clusteraks.identity[0].principal_id
  }
}

# output ip {
#   value = data.azurerm_public_ip.ip.ip_address
# }

output principal_id {
  value = azurerm_kubernetes_cluster.clusteraks.identity[0].principal_id
}

output raw_kube_config {
  value = azurerm_kubernetes_cluster.clusteraks.kube_admin_config_raw
}

output raw_kube_config_g_s_s {
  value     = azurerm_kubernetes_cluster.clusteraks.kube_admin_config
  sensitive = true
}

output node_resource_group {
  value = azurerm_kubernetes_cluster.clusteraks.node_resource_group
}

output aks_cluster_name {
  value = azurerm_kubernetes_cluster.clusteraks.name
}

output kubernetes_version {
  value = azurerm_kubernetes_cluster.clusteraks.kubernetes_version
}

output clusteraks_id {
  value = azurerm_kubernetes_cluster.clusteraks
}

output object_id {
  value = azurerm_kubernetes_cluster.clusteraks.key_vault_secrets_provider[0].secret_identity[0].object_id
}

output rg_name {
  value = azurerm_kubernetes_cluster.clusteraks.resource_group_name
}

output location {
  value = azurerm_kubernetes_cluster.clusteraks.location
}
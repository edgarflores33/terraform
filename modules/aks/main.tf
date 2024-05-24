resource "azurerm_kubernetes_cluster" "clusteraks" {
  name                    = local.aks_name
  #resource_group_name     = var.rsgr_name
  location                = var.rsgr_loc
  resource_group_name     = "pe-bcp-temp-environment"
  dns_prefix              = lower(var.infr-env.scope)
  kubernetes_version      = var.kubernetes_version

  default_node_pool {
    #name                  = "infr${lower(var.infr-env.scope)}"
    name       			      = lower(format("%s%s%s%s", "vmss", var.infr-env.scope, var.infr-env.env, "01"))
    #enable_auto_scaling   = var.enable_auto_scaling
    #min_count             = var.enable_auto_scaling ? local.scale_config.min_count:null
    #max_count             = var.enable_auto_scaling ? local.scale_config.max_count:null
    #node_count            = var.enable_auto_scaling ? null : var.node_count
    vm_size               = local.vm_size
    #type                  = "VirtualMachineScaleSets"
    #os_disk_size_gb       = var.os_disk_size_gb
    #vnet_subnet_id        = var.aks_default_subnet_id
    #max_pods              = var.max_pods == 0 ? local.size_selected.max_pods: var.max_pods
  }

#   network_profile {
#     network_plugin    = var.network_plugin
#     network_policy    = var.network_policy
#     #outbound_type     = "userDefinedRouting"
#   }

  azure_policy_enabled = true

  tags = local.tags

  timeouts {
    create = "60m"
    delete = "2h"
  }

  identity {
    type = "SystemAssigned"
  }

  key_vault_secrets_provider {   
       secret_rotation_enabled  = true
       secret_rotation_interval = var.secret_rotation_interval
  }
  
  lifecycle {
    ignore_changes = [windows_profile,kubernetes_version]
  }

  sku_tier = local.sku_tier
}

# data "azurerm_subscription" "current" {
# }

# data "azurerm_client_config" "current" {
# }

# data "azurerm_public_ip" "ip" {
#   name                = reverse(split("/", tolist(azurerm_kubernetes_cluster.clusteraks.network_profile.0.load_balancer_profile.0.effective_outbound_ips)[0]))[0]
#   resource_group_name = azurerm_kubernetes_cluster.clusteraks.node_resource_group
# }

# resource "azurerm_role_assignment" "system_assigned" {
#   depends_on = [azurerm_kubernetes_cluster.clusteraks]
#   scope = var.aks_default_subnet_id
#   role_definition_name = "Network Contributor"
#   skip_service_principal_aad_check = true
#   principal_id         = azurerm_kubernetes_cluster.clusteraks.identity[0].principal_id
#   lifecycle {
#     ignore_changes = all
#   }
# }

# resource "azurerm_kubernetes_cluster_node_pool" "node_pool"{
#   count                 = length(var.aks_app_subnet_ids)
#   name       			= lower(format("%s%s%s%s", "vmss", var.infr-env.scope, var.infr-env.env, var.node_pools[count.index]))
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.clusteraks.id
#   enable_auto_scaling   = var.enable_auto_scaling
#   min_count             = var.enable_auto_scaling ? local.scale_config.min_count:null
#   max_count             = var.enable_auto_scaling ? local.scale_config.max_count:null
#   node_count            = var.enable_auto_scaling ? null : var.node_count
#   vm_size               = local.vm_size
#   os_disk_size_gb       = var.os_disk_size_gb
#   vnet_subnet_id        = var.aks_app_subnet_ids[count.index]
#   max_pods              = var.max_pods == 0 ? local.size_selected.max_pods: var.max_pods
#   tags 					= local.tags
#   depends_on            = [azurerm_kubernetes_cluster.clusteraks]
# }
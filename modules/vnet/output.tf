output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_address_prefixes" {
  value = module.subnet.subnet_address_prefixes
}

output "subnet_id" {
  value = module.subnet.subnet_id
}

output "name" {
  value = azurerm_virtual_network.vnet.name
}

output "rsgr_name" {
  value = azurerm_virtual_network.vnet.resource_group_name
}
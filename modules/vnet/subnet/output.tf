output "subnet_address_prefixes" {
  value = azurerm_subnet.subnet.address_prefixes[0]
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}
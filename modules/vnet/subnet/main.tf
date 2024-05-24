resource "azurerm_subnet" "subnet" {
  name                 = local.map_custom_name.resource_name
  #resource_group_name  = var.rsgr_name
  resource_group_name  = "pe-bcp-temp-environment"
  address_prefixes     = [var.subnet_address]
  virtual_network_name = var.vnet_name
}
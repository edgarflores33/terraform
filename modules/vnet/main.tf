resource "azurerm_virtual_network" "vnet" {
  name                = local.map_custom_name.resource_name
  #resource_group_name = var.rsgr_name
  resource_group_name = "pe-bcp-temp-environment"
  location            = var.rsgr_loc  
  address_space       = var.vnet_address_space
  tags                = local.tags
}

module "subnet" { 
source               = "./subnet"
#rsgr_name            = var.rsgr_name
rsgr_name            = "pe-bcp-temp-environment"
subnet_address       = var.subnet_address
vnet_name            = local.map_custom_name.resource_name
infr-env             = var.infr-env
depends_on           = [azurerm_virtual_network.vnet]
}
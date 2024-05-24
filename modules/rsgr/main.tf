resource "azurerm_resource_group" "rsgr" {
  # name      = local.map_custom_name.rg_name
  name      = "pe-bcp-temp-environment"
  location  = var.rsgr_loc
  tags      = local.tags
}
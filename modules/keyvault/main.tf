data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault001" {
  name                = local.map_custom_name.keyvault_name  
  #resource_group_name = var.rsgr_name  
  resource_group_name = "pe-bcp-temp-environment"  
  location            = var.rsgr_loc
  sku_name            = var.keyvault_skuname
  tenant_id           = data.azurerm_client_config.current.tenant_id

  tags = local.tags  
}


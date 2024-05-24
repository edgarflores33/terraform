resource "azurerm_redis_cache" "redis-001" {
  name                = local.map_custom_name.redis_name
  #resource_group_name = var.rsgr_name
  resource_group_name = "pe-bcp-temp-environment"
  location            = var.rsgr_loc  
  capacity            = 2
  family              = lower(local.redis_skuname) == "premium" ? "P" : "C"
  sku_name            = local.redis_skuname
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"
  
  redis_configuration {
  }

  tags = local.tags
}
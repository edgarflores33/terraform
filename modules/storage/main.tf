################################# Storage Account ##############################################
resource "azurerm_storage_account" "storageaccount001" {
  name                     = local.map_custom_name.stmb-name
  resource_group_name      = var.rsgr_name
  location                 = var.rsgr_loc
  account_tier             = "Standard"  
  account_replication_type = "GRS"
  
  static_website {
    index_document     = "index.html"
    error_404_document = "error.html" 
  }
  
  tags = local.tags
}

resource "azurerm_storage_blob" "storageblob" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storageaccount001.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "../modules/storage/index.html"
  depends_on             = [azurerm_storage_account.storageaccount001]
}  
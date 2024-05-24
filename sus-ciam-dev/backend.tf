terraform {
  backend "azurerm" {
    resource_group_name  = "rg01"
    storage_account_name = "storageaccount01010101"
    container_name       = "data"
    key                  = "terraform.tfstate"
  }
}
terraform { 
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.61.0"
      #version = "~> 3.100.0"
    } 
  }
}

provider "azurerm" { 
  # tenant_id       = var.TENANT_ID
  # subscription_id = var.SUBSCRIPTION_ID_MAIN
  features {

  }
}

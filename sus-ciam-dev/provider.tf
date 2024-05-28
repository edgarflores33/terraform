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
  # tenant_id = "7659b7f1-9b0f-4f0e-987d-5bfd54aa08cd"
  # subscription_id = "e4b49579-e522-4b37-860a-e606f131e4c4"
  features {

  }
}

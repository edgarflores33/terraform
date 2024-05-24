######################################### Resource Group #1 ###################################################

module "rsgr-01" {
  source     = "../modules/rsgr"
  rsgr_loc   = var.location
  infr-env   = var.infr-env
  audit      = var.audit  
}

# module "vnet" {
#   source             = "../modules/vnet"
#   #rsgr_name          = module.rsgr-03.rsgr_name
#   #rsgr_name          = "pe-bcp-temp-environment"
#   rsgr_loc           = var.location
#   infr-env           = var.infr-env
#   audit              = var.audit
#   vnet_address_space = ["10.200.0.0/21"]
#   subnet_address     = "10.200.4.128/26"
#   #depends_on         = [module.rsgr-01]
# }

# module "redis" {
#   source        = "../modules/redis"
#   #rsgr_name     = module.rsgr-03.rsgr_name
#   rsgr_loc      = var.location
#   infr-env      = var.infr-env
#   audit         = var.audit
#   subnet_id     = module.vnet.subnet_id
#   depends_on    = [module.vnet]
# }

# module "keyvault" {
#   source           = "../modules/keyvault"
#   #rsgr_name       = module.rsgr-01.rsgr_name
#   rsgr_loc         = var.location
#   infr-env         = var.infr-env
#   audit            = var.audit
#   keyvault_skuname = "standard"    
# }

# module "aks" {
#   source                = "../modules/aks"
#   #rsgr_name             = module.rsgr-03.rsgr_name
#   rsgr_loc              = var.location
#   infr-env              = var.infr-env
#   audit                 = var.audit
#   aks_subnet            = module.vnet.subnet_address_prefixes
#   aks_default_subnet_id = module.vnet.subnet_id
#   # aks_subnet            = module.subnet002.subnet_address_prefixes
#   # aks_default_subnet_id = module.subnet002.subnet_id  
#   #ks_app_subnet_ids    = [module.subnet003.subnet_id]
#   kubernetes_version    = "1.24.9"
#   #enable_auto_scaling   = false
#   node_count            = 2                   # solo si enable_auto_scaling = false,  default = 1  
#   #availability_zones    = ["1", "2"]
#   #node_pools            = ["01"]
#   #depends_on            = [module.nsg02, module.nsg03]
# }

# module "storage" {
#   source                            = "../modules/storage"
#   rsgr_name                         = module.rsgr-01.rsgr_name
#   rsgr_loc                          = var.location
#   infr-env                          = var.infr-env
#   audit                             = var.audit 
#   storage_account_tier              = "Standard"
#   storage_account_replication_type  = "GRS"
#   static_website_index_document     = "index.html"
#   static_website_error_404_document = "error.html"
#   depends_on                        = [module.rsgr-01]
# }

variable "infr-env" {
  description = "Variables de infra de ambiente scope,env"
  type = object({
    scope  = string
    env    = string
  })
  default = { scope = "LoginUnico", env = "dev"}
}

variable "audit" {
  description = "Variables de auditoria"
  type = object({
    codproy    = string
    costCenter = string
    deployedBy = string
  })
  default = { codproy = "CIAM", costCenter = "EXT-015836-00351", deployedBy = "raguileg" }
}

variable "location" {
    type = string
    default = "East US"
}

###############################################################################################

# The Active Directory tenant ID.
# variable TENANT_ID { 
#   type = string 
# }

# Data for the "main" subscription and SP
# variable SUBSCRIPTION_ID_MAIN { 
#   type = string 
# }

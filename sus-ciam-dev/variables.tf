variable "infr-env" {
  description = "Variables de infra de ambiente scope,env"
  type = object({
    scope  = string
    env    = string
  })
}

variable "audit" {
  description = "Variables de auditoria"
  type = object({
    codproy    = string
    costCenter = string
    deployedBy = string
  })
}

variable "location" {
    type = string
}

###############################################################################################

# The Active Directory tenant ID.
variable TENANT_ID { 
  type = string 
}

# Data for the "main" subscription and SP
variable SUBSCRIPTION_ID_MAIN { 
  type = string 
}

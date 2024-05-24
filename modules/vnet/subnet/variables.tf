variable "subnet_address" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "rsgr_name" {
  type = string
}

locals {
  resource-code = "snet"
  map_custom_name = {
    resource_name = lower(format("%s%s%s%s%s%s%s", local.resource-code, "-", var.infr-env.scope, "-", var.infr-env.env, "-", var.seq_number))
    
  }
}

###################################### INICIO Variables Base ###################################################

variable "infr-env" {
  description = "Variables de infra de ambiente scope,env"
  type = object({
    scope  = string
    env    = string
  })
  validation {
    condition     = length(var.infr-env.scope) > 2
    error_message = "El scope o canal debe ser mayor a 2 caracteres"
  }
  validation {
    condition     = length(var.infr-env.env) > 0 && length(var.infr-env.env) < 6
    error_message = "El codigo de ambiente debe ser mayor a 2 caracteres y menor a 6 caracteres"
  }
}

variable "seq_number" {
    type = string
    default = "001"
}

###################################### FIN Variables Base ###################################################
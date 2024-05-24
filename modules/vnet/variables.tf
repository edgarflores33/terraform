# variable "rsgr_name" {
#   type = string
# }

variable "rsgr_loc" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnet_address" {
  type = string
}

locals {
  tags = {
    CodigoProyecto   = var.audit.codproy
    costCenter       = var.audit.costCenter
    deployedBy       = var.audit.deployedBy
    Ambiente         = var.infr-env.env
    NombreAplicacion = var.infr-env.scope
  }
  resource-code = "vnet"
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

variable "audit" {
  description = "Variables de auditoria"
  type = object({
    codproy    = string
    costCenter = string
    deployedBy = string
  })
  validation {
    condition     = length(var.audit.codproy) > 3
    error_message = "El codproy debe ser mayor a 3 caracteres. Ejemplo: CIAM"
  }
  validation {
    condition     = length(var.audit.costCenter) > 3
    error_message = "El costCenter debe ser mayor a 3 caracteres."
  }
  validation {
    condition     = length(var.audit.deployedBy) > 3
    error_message = "El deployedBy debe ser mayor 3 digitos."
  }
}

variable "seq_number" {
    type = string
    default = "001"
}

###################################### FIN Variables Base ###################################################
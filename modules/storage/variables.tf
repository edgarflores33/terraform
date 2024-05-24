################################# Variables Generales ##############################################
variable "rsgr_name" {
  type = string
}

variable "rsgr_loc" {
  type = string
}

locals {
  tags = {
    CodigoProyecto   = var.audit.codproy
    NombreOwner      = var.audit.owner
    Criticidad       = var.audit.criticidad
    Ambiente         = var.infr-env.env
    NombreAplicacion = var.infr-env.scope
  }

  stmb-code = "stmb"
  map_custom_name = {
    stmb-name = lower(format("%s%s%s%s", local.stmb-code, var.infr-env.scope, var.infr-env.env, var.seq_number))
  }
}

###################################### INICIO Variables Base ###################################################

variable "infr-env" {
  description = "Variables de infra de ambiente scope,env,number"
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
    owner      = string
    criticidad = string
  })
  validation {
    condition     = length(var.audit.codproy) > 3
    error_message = "El codproy debe ser mayor a 3 caracteres. Ejemplo: 1497 - Producción De Sistemas | 1608 - Innovación"
  }
  validation {
    condition     = length(var.audit.owner) > 3
    error_message = "El owner debe ser mayor a 3 caracteres. Ejemplo: URPI | SIGE | APP MOVL "
  }
  validation {
    condition     = length(var.audit.criticidad) > 3
    error_message = "La criticidad debe ser mayor 3 digitos. Ejemplo: Muy alto | Alto | Medio | Bajo"
  }
}

variable "seq_number" {
    type = string
    default = "001"
}

###################################### FIN Variables Base ###################################################
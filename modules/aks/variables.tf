variable "secret_rotation_interval" {
  description = "The interval to poll for secret rotation. This attribute is only set when secret_rotation is true and defaults to 2m"
  default = "2m"
  type = string
}

variable "vm_size" {
  default = ""
  description = "Tamaño de la maquina virtual para los nodos revisar, por defecto usa de la tabla de sizing (S,M,L,XL) revisar tabla recomenda"
}

variable "aks_subnet" {
  #type = map(string)
  type = string
  description = "Una subnet para el AKS valor debe ser un segmento de la VNET. Ejemplo:  \"10.10.0.0/25\" "
}

variable "aks_default_subnet_id" {
  type        = string
  default     = ""
}

variable "min_nodes" {
  default = 0
  description = "Cantidad de nodos minimo en el cluster, por defecto usa de la mascara en la tabla de sizing  revisar tabla"
}

variable "max_nodes" {
  default = 0
  description = "Cantidad de nodos maximo en el cluster, por defecto usa de la mascara en la tabla de sizing revisar tabla"
}

variable "max_pods" {
  default = 0
  description = "La cantidad de pods minima es 30 para el aprovisionamiento en todo el cluster, por defecto usa de la tabla de sizing (S,M,L,XL,C) revisar tabla "
}

# variable "enable_auto_scaling" {
#   default = true
#   description = "Habilita el autoscalado de nodos. Default: true"
# }

variable "node_count" {
  default = 1
  description = "Cantidad de nodos activos, para mantener el valor se debe desactivar el autoescalado de enable_auto_scaling=false"
}

# variable "availability_zones" {
#   type = list(string)
#   default = ["1", "2", "3"]
# }

variable "kubernetes_version" {
  description = "Version of Kubernetes to install"
  type = string
  default = "1.24.9"  
}

variable "os_disk_size_gb" {
  description = "The disk size"
  type        = number
  default     = 50
}

# variable "network_plugin" {
#   type = string
#   default = "azure"  
# }

# variable "network_policy" {
#   type = string
#   default = "azure"  
# }

variable "ignore_changes" {
  type = list
  default =  ["windows_profile", "default_node_pool"]
}

locals {

  sku_tier  = var.infr-env.env == "prod" ? "Paid" : "Free"
  
  tags = {
    CodigoProyecto   = var.audit.codproy
    costCenter       = var.audit.costCenter
    deployedBy       = var.audit.deployedBy
    Ambiente         = var.infr-env.env
    NombreAplicacion = var.infr-env.scope
  }

  vm_dev_size = {
    "26" = { vm = "Standard_B4ms", max_pods = 30, max_nodes = 7, min_nodes = 1 }
    "25" = { vm = "Standard_B8ms", max_pods = 30, max_nodes = 10, min_nodes = 1 }
    "24" = { vm = "Standard_B8ms", max_pods = 30, max_nodes = 10, min_nodes = 1 }
  }

  min_nodes_arch = lower(var.infr-env.env) == "prod" ? var.min_nodes > 1 ? var.min_nodes : 2 : var.min_nodes == 0 ? 1 : var.min_nodes

  vm_cert_prod_size = {
    "26" = { vm = "Standard_D4s_v4", max_pods = 30, max_nodes = 7, min_nodes = local.min_nodes_arch }
    "25" = { vm = "Standard_D8s_v4", max_pods = 30, max_nodes = 19, min_nodes = local.min_nodes_arch }
    "24" = { vm = "Standard_D8s_v4", max_pods = 30, max_nodes = 19, min_nodes = local.min_nodes_arch }
  }

  aks-code = "aks-service"
  aks_name = lower(format("%s%s%s%s%s%s%s", local.aks-code, "-", var.infr-env.scope, "-", var.infr-env.env, "-", var.seq_number))
  size_selected = lower(var.infr-env.env) == "dev" ? local.vm_dev_size[split("/",var.aks_subnet)[1]]: local.vm_cert_prod_size[split("/",var.aks_subnet)[1]]
  
  scale_config =  {
    max_count = var.max_nodes == 0 ? local.size_selected.max_nodes: var.max_nodes,
    min_count = var.min_nodes == 0 ? local.size_selected.min_nodes: var.min_nodes
  }

  vm_size = var.vm_size == "" ? local.size_selected.vm : var.vm_size
}

# variable "node_pools" {
#   type = list(string)
#   default = ["001"]
# }

# variable "aks_app_subnet_ids" {
#   type = list(string)
#   default = []
# }

# variable "rsgr_name" {
#   type        = string
#   default     = ""
# }

variable "rsgr_loc" {
  description = "Específica la region. Default: eastus2"
  type        = string
  default     = "eastus2"
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
    error_message = "El owcostCenterner debe ser mayor a 3 caracteres."
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
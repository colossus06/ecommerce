variable "rg-hub-location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "rg-spoke1-location" {
  type        = string
  default     = "westus"
  description = "Location of the resource group."
}

variable "rg-spoke2-location" {
  type        = string
  default     = "swedencentral"
  description = "Location of the resource group."
}


variable "rg-hub" {
  type        = string
  default     = "rg-hub-argocd"
  description = "Resource group name"
}

variable "rg-spoke1" {
  type        = string
  default     = "rg-spoke1-argocd"
  description = "Resource group name"
}

# variable "rg-spoke2" {
#   type        = string
#   default     = "rg-spoke2-argocd"
#   description = "Resource group name"
# }
variable "aks_hub_cluster_name" {
  type        = string
  default     = "hub-clu"
  description = "Hub cluster name"
}

variable "aks_spoke1_cluster_name" {
  type        = string
  default     = "spoke1-clu"
  description = "Spoke 1 cluster name"
}


# variable "aks_spoke2_cluster_name" {
#   type        = string
#   default     = "spoke2-clu"
#   description = "Spoke 2 cluster name"
# }

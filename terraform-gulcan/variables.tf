variable "resource_group_location" {
  type        = string
  default     = "swedencentral"
  description = "Location of the resource group."
}
variable "sa_name" {
  type        = string
  default     = "sa-azuredevop"
  description = "Storage account name."
}

variable "sc_name" {
  type        = string
  default     = "sc-azuredevops"
  description = "Storage container name."
}


variable "resource_group_name" {
  type        = string
  default     = "rg-azuredevops"
  description = "Resource group name"
}

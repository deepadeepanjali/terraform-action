variable "keyvault" {
  description = "Name of keyvault"
  type        = string
}

variable "resourcegroup" {
  description = "The resource group of the Key Vault"
  type        = string
}

variable "foldername" {
  description = "Foldername"
  type        = string
}

variable "bot_configurations" {
  description = "Map of bot configurations including botname, ad_group_objectid"
  type = map(object({
    botname     = string
    ad_group_objectid    = string
  }))
}

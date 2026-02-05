variable "customer_name" {
  description = "The name of the customer for whom the resources are being created."
  type        = string
}

variable "customer_abbreviation" {
  description = "The abbreviation of the customer name."
  type        = string
}

variable "environment" {
  description = "The environment in which the resources are deployed. Example values: dev, test, prod."
  type        = string
}

variable "location" {
  description = "The location of the resource group in which to create the resources. Example values: North Europe, West Europe, etc."
  type        = string
  # default = "North Europe"
}

variable "default_tags" {
  description = "The default tags to apply to all resources."
  type        = map(string)
  default = {
    managed_by = "Terraform"
  }
}

variable "enable_telemetry" {
  description = "Enable telemetry for the resources."
  type        = bool
  default     = false
}

variable "enabled_features" {
  description = "The features to enable for the resources."
  type        = list(string)
  default     = ["rg", "apim", "kv", "log", "sb", "func", "logic", "storage", "vnet", "natgw", "pip", "cosmosdb", "evgd"]
}

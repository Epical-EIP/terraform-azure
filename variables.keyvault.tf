variable "key_vaults" {
  description = "The Key Vaults."
  type = map(object({
    resource_group                = string
    sku                           = string
    soft_delete_retention_days    = optional(number)
    purge_protection_enabled      = optional(bool)
    public_network_access_enabled = optional(bool)
    network_acls = optional(object({
      bypass                     = optional(string, "None")
      default_action             = optional(string, "Deny")
      ip_rules                   = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
    }))
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
      principal_type                         = optional(string, null)
    })))
    diagnostic_settings = optional(map(object({
      workspace                      = string
      resource_group                 = string
      log_categories                 = list(string)
      metric_categories              = list(string)
      name                           = optional(string)
      log_analytics_destination_type = optional(string)
    })))
  }))
  default = {}
}
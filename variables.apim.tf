variable "apim_instances" {
  description = "The API Management Instances."
  type = map(object({
    publisher_name  = string
    publisher_email = string
    sku             = string
    resource_group  = string
    managed_identities = optional(object({
      system_assigned            = optional(bool, true) # Default enable System Assigned Identity
      user_assigned_resource_ids = optional(set(string), [])
    }), { system_assigned = false })
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
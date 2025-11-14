variable "eventgrid_domains" {
  description = "A map of Event Grid Domains to create."
  type = map(object({
    resource_group = string
    input_schema   = optional(string, "CustomEventSchema")
    topics         = optional(list(string), [])
    input_mapping_default_values = optional(object({
      data_version = string
      event_type   = string
      subject      = string
    }), {
      data_version = null
      event_type   = null
      subject      = null
    })
    input_mapping_fields = optional(object({
      data_version = string
      event_time   = string
      event_type   = string
      id           = string
      subject      = string
      topic        = string
    }))
    managed_identities = optional(object({
      system_assigned            = optional(bool, true) # Default enable System Assigned Identity
      user_assigned_resource_ids = optional(set(string), [])
    }), { system_assigned = true })
  }))
  default = {}
}
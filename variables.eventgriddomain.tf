variable "eventgrid_domains" {
  description = "A map of Event Grid Domains to create."
  type = map(object({
    resource_group = string
    input_schema   = optional(string, "CloudEventSchemaV1_0")
    topics         = optional(list(string), [])
    managed_identities = optional(object({
      system_assigned            = optional(bool, true) # Default enable System Assigned Identity
      user_assigned_resource_ids = optional(set(string), [])
    }), { system_assigned = true })
  }))
  default = {}
}
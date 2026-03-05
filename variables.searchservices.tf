variable "search_services" {
  type = map(object({
    resource_group               = string
    sku                          = optional(string, "basic") # Default SKU is Basic
    semantic_search_sku          = optional(string, null)    # Default is null
    allowed_ips                  = optional(list(string), null)
    local_authentication_enabled = optional(bool, true) # Default disable local authentication
    managed_identities = optional(object({
      system_assigned            = optional(bool, true) # Default enable System Assigned Identity
      user_assigned_resource_ids = optional(set(string), [])
    }), { system_assigned = true })
    public_network_access_enabled = optional(bool, true) # Default enable public network access
    tags                          = optional(map(string), {})
  }))
}
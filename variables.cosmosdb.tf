variable "cosmosdb_accounts" {
  type = map(object({
    resource_group    = string
    location          = optional(string, null)
    offer_type        = optional(string, "Standard")
    kind              = optional(string, "GlobalDocumentDB")
    free_tier_enabled = optional(bool, false)
    consistency_policy = optional(object({
      max_interval_in_seconds = optional(number, 5)
      max_staleness_prefix    = optional(number, 100)
      consistency_level       = optional(string, "ConsistentPrefix")
    }), { consistency_level = "Session" })
    geo_locations = optional(set(object({
      location          = string
      failover_priority = number
      is_zone_redundant = optional(bool, true)
    })), null)
    enable_automatic_failover       = optional(bool, false)
    virtual_network                 = optional(string, null)
    subnet                          = optional(string, null)
    ip_range_filter                 = optional(set(string), [])
    enable_multiple_write_locations = optional(bool, false)
    capabilities                    = optional(set(object({ name = string })), [])
    backup = optional(object({
      retention_in_hours  = optional(number, 8)
      interval_in_minutes = optional(number, 240)
      storage_redundancy  = optional(string, "Geo")
      type                = optional(string, "Continuous")
    tier = optional(string, "Continuous30Days") }), [])

    periodic_backup_interval_in_minutes = optional(number, 240) # Default 4 hours
    periodic_backup_retention_in_hours  = optional(number, 8)   # Default 8 hours
    continuous_backup_retention_in_days = optional(number, 7)   # Default 7 days
    tags                                = optional(map(string), {})
    managed_identities = optional(object({
      system_assigned            = optional(bool, true) # Default enable System Assigned Identity
      user_assigned_resource_ids = optional(set(string), [])
    }), { system_assigned = true })
    cors_rule = optional(object({
      allowed_headers    = set(string)
      allowed_methods    = set(string)
      allowed_origins    = set(string)
      exposed_headers    = set(string)
      max_age_in_seconds = optional(number, null)
    }), null)
    network_acl_bypass_for_azure_services = optional(bool, false)
    public_network_access_enabled         = optional(bool, false)
  }))
}
variable "cosmosdb_accounts" {
  type = map(object({
    resource_group       = string
    location             = optional(string, null)
    offer_type           = optional(string, "Standard")
    kind                 = optional(string, "GlobalDocumentDB")
    free_tier_enabled   = optional(bool, false)
    consistency_policy   = optional(object({
      consistency_level       = string
      max_interval_in_seconds = optional(number, null)
      max_staleness_prefix    = optional(number, null)
    }), { consistency_level = "Session" })
    geo_locations        = optional(list(object({
      location          = string
      failover_priority = number
      is_zone_redundant = optional(bool, false)
    })), [])
    enable_automatic_failover = optional(bool, false)
    virtual_network = optional(string, null)
    subnet          = optional(string, null)
    ip_range_filter         = optional(string, null)
    enable_multiple_write_locations = optional(bool, false)
    capabilities            = optional(list(string), []) 
    backup_policy_type      = optional(string, "Periodic") # Options: Periodic, Continuous
    periodic_backup_interval_in_minutes = optional(number, 240) # Default 4 hours
    periodic_backup_retention_in_hours   = optional(number, 8)   # Default 8 hours
    continuous_backup_retention_in_days   = optional(number, 7)   # Default 7 days
    tags                    = optional(map(string), {})
  }))
}
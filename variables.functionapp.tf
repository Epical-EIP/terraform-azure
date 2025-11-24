variable "function_apps" {
  type = map(object({
    resource_group              = string
    storage_account             = string
    service_plan                = string
    enable_telemetry            = optional(bool, false)
    fc1_runtime_name            = optional(string, "dotnet-isolated") # Default .NET Isolated
    fc1_runtime_version         = optional(string, "8.0")             # Default .NET 8
    function_app_uses_fc1       = optional(bool, true)                # Default uses Flex Consumption Plan
    functions_extension_version = optional(string, "~4")              # Default Azure Functions runtime Version 4
    https_only                  = optional(bool, true)                # Default HTTPS only
    instance_memory_in_mb       = optional(number, 512)               # Default instance memory 512 MB
    key_vault                   = optional(string, null)
    storage_uses_managed_identity = optional(bool, false)              # Default uses Managed Identity for Storage Account
    storage_authentication_type = optional(string, "StorageAccountConnectionString") # Default Storage Account Connection String
    enable_application_insights = optional(bool, true) # Default enable Application Insights
    log_analytics_workspace     = optional(string, null)
    site_config                 = optional(map(any), {}) # Additional site config settings
    app_settings               = optional(map(string), {})
    virtual_network           = optional(string, null)
    subnet                    = optional(string, null)
    managed_identities = optional(object({
      system_assigned            = optional(bool, true) # Default enable System Assigned Identity
      user_assigned_resource_ids = optional(set(string), [])
    }), { system_assigned = true })
  }))
}

variable "storage_accounts" {
  description = "The Storage Accounts."
  type = map(object({
    resource_group = string

    access_tier              = optional(string)
    account_tier             = optional(string)
    account_kind             = optional(string)
    account_replication_type = optional(string)

    enable_https_traffic_only     = optional(bool, true)
    public_network_access_enabled = optional(bool, false)
    sftps_enabled                 = optional(bool, false)
    large_file_share_enabled      = optional(bool, true)
    shared_access_key_enabled     = optional(bool, true)
    is_hns_enabled                = optional(bool, null) #Hierarchical Namespace for Data Lake Gen2

    static_website = optional(object({
      index_document     = optional(string)
      error_404_document = optional(string)
    }))

    network_rules = optional(object({
      bypass                     = optional(set(string), ["AzureServices"])
      default_action             = optional(string, "Deny")
      ip_rules                   = optional(set(string), [])
      virtual_network_subnet_ids = optional(set(string), [])
      private_link_access = optional(list(object({
        endpoint_resource_id = string
        endpoint_tenant_id   = optional(string)
      })))
      timeouts = optional(object({
        create = optional(string)
        delete = optional(string)
        read   = optional(string)
        update = optional(string)
      }))
    }), null)
    blob_properties = optional(object({
      change_feed_enabled           = optional(bool)
      change_feed_retention_in_days = optional(number)
      default_service_version       = optional(string)
      last_access_time_enabled      = optional(bool)
      versioning_enabled            = optional(bool, true)
      container_delete_retention_policy = optional(object({
        days = optional(number, 7)

      }), { days = 7 })

      cors_rule = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })))
      delete_retention_policy = optional(object({
        days = optional(number, 7)
      }), { days = 7 })
      diagnostic_settings = optional(map(object({
        name                                     = optional(string, null)
        log_categories                           = optional(set(string), [])
        log_groups                               = optional(set(string), ["allLogs"])
        metric_categories                        = optional(set(string), ["AllMetrics"])
        log_analytics_destination_type           = optional(string, "Dedicated")
        workspace_resource_id                    = optional(string, null)
        resource_id                              = optional(string, null)
        event_hub_authorization_rule_resource_id = optional(string, null)
        event_hub_name                           = optional(string, null)
        marketplace_partner_resource_id          = optional(string, null)
      })), {})
      restore_policy = optional(object({
        days = number
      }))
    }))
    containers = optional(map(object({
      public_access                  = optional(string, "None")
      metadata                       = optional(map(string))
      name                           = string
      default_encryption_scope       = optional(string)
      deny_encryption_scope_override = optional(bool)
      enable_nfs_v3_all_squash       = optional(bool)
      enable_nfs_v3_root_squash      = optional(bool)
      immutable_storage_with_versioning = optional(object({
        enabled = bool
      }))

      role_assignments = optional(map(object({
        role_definition_id_or_name             = string
        principal_id                           = string
        principal_type                         = optional(string, null)
        description                            = optional(string, null)
        skip_service_principal_aad_check       = optional(bool, false)
        condition                              = optional(string, null)
        condition_version                      = optional(string, null)
        delegated_managed_identity_resource_id = optional(string, null)
      })), {})

      timeouts = optional(object({
        create = optional(string)
        delete = optional(string)
        read   = optional(string)
        update = optional(string)
      }))
    })))
    queues = optional(map(object({
      metadata = optional(map(string))
      name     = string
      role_assignments = optional(map(object({
        role_definition_id_or_name             = string
        principal_id                           = string
        principal_type                         = optional(string, null)
        description                            = optional(string, null)
        skip_service_principal_aad_check       = optional(bool, false)
        condition                              = optional(string, null)
        condition_version                      = optional(string, null)
        delegated_managed_identity_resource_id = optional(string, null)
      })), {})
      timeouts = optional(object({
        create = optional(string)
        delete = optional(string)
        read   = optional(string)
        update = optional(string)
      }))
    })))
    queue_properties = optional(map(object({
      cors_rule = optional(map(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })), {})
      hour_metrics = optional(object({
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
        version               = string
      }))
      logging = optional(object({
        delete                = bool
        read                  = bool
        retention_policy_days = optional(number)
        version               = string
        write                 = bool
      }))
      minute_metrics = optional(object({
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
        version               = string
      }))
    })))
    tables = optional(map(object({
      name = string
      signed_identifiers = optional(list(object({
        id = string
        access_policy = optional(object({
          expiry_time = string
          permission  = string
          start_time  = string
        }))
      })))

      role_assignments = optional(map(object({
        role_definition_id_or_name             = string
        principal_id                           = string
        principal_type                         = optional(string, null)
        description                            = optional(string, null)
        skip_service_principal_aad_check       = optional(bool, false)
        condition                              = optional(string, null)
        condition_version                      = optional(string, null)
        delegated_managed_identity_resource_id = optional(string, null)
      })), {})

      timeouts = optional(object({
        create = optional(string)
        delete = optional(string)
        read   = optional(string)
        update = optional(string)
      }))
    })))
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
    share_properties = optional(object({
      cors_rule = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })))
      diagnostic_settings = optional(map(object({
        name                                     = optional(string, null)
        log_categories                           = optional(set(string), [])
        log_groups                               = optional(set(string), ["allLogs"])
        metric_categories                        = optional(set(string), ["AllMetrics"])
        log_analytics_destination_type           = optional(string, "Dedicated")
        workspace_resource_id                    = optional(string, null)
        resource_id                              = optional(string, null)
        event_hub_authorization_rule_resource_id = optional(string, null)
        event_hub_name                           = optional(string, null)
        marketplace_partner_resource_id          = optional(string, null)
      })), {})
      retention_policy = optional(object({
        days = optional(number)
      }))
      smb = optional(object({
        authentication_types            = optional(set(string))
        channel_encryption_type         = optional(set(string))
        kerberos_ticket_encryption_type = optional(set(string))
        multichannel_enabled            = optional(bool)
        versions                        = optional(set(string))
      }))
    }))
    storage_data_lake_gen2_filesystems = optional(map(object({
      default_encryption_scope = optional(string)
      group                    = optional(string)
      name                     = string
      owner                    = optional(string)
      properties               = optional(map(string))
      ace = optional(set(object({
        id          = optional(string)
        permissions = string
        scope       = optional(string)
        type        = string
      })))
      timeouts = optional(object({
        create = optional(string)
        delete = optional(string)
        read   = optional(string)
        update = optional(string)
      }))
    })))
  }))
  default = {}
}
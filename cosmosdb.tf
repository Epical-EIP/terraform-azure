module "avm-res-documentdb-databaseaccount" {
  source  = "Azure/avm-res-documentdb-databaseaccount/azurerm"
  version = "0.6.0"

  for_each = contains(var.enabled_features, "cosmosdb") ? var.cosmosdb_accounts : {}

  name                                  = join("-", ["cosmos", local.name_prefix, each.key, local.name_suffix])
  location                              = each.value.location != null ? each.value.location : var.location
  resource_group_name                   = azurerm_resource_group.rg["${each.value.resource_group}"].name
  free_tier_enabled                     = each.value.free_tier_enabled
  consistency_policy                    = each.value.consistency_policy
  geo_locations                         = each.value.geo_locations
  capabilities                          = each.value.capabilities
  cors_rule                             = each.value.cors_rule
  network_acl_bypass_for_azure_services = each.value.network_acl_bypass_for_azure_services
  public_network_access_enabled         = each.value.public_network_access_enabled
  managed_identities                    = each.value.managed_identities

  virtual_network_rules = each.value.virtual_network != null ? [
    {
      subnet_id = each.value.virtual_network != null && each.value.subnet != null ? module.avm-res-network-virtualnetwork-subnet["${each.value.virtual_network}-${each.value.subnet}"].resource_id : null
    }
  ] : []

  ip_range_filter  = each.value.ip_range_filter
  enable_telemetry = var.enable_telemetry
  tags             = merge(var.default_tags, each.value.tags)
}
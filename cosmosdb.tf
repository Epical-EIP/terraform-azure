module "vm-res-cosmosdb" {
  source  = "Azure/avm-res-cosmosdb/azurerm"
  version = "0.19.1"

  for_each = contains(var.enabled_features, "cosmosdb") ? var.cosmosdb_accounts : {}

  name                = join("-", ["cosmosdb", local.name_prefix, each.key, local.name_suffix])
  location            = each.value.location != null ? each.value.location : var.location
  resource_group_name = azurerm_resource_group.rg["${each.value.resource_group}"].name
  account_kind        = each.value.account_kind
  account_tier        = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  
  virtual_network_rules = each.value.virtual_network != null ? [
    {
      subnet_id = each.value.virtual_network != null && each.value.subnet != null ? module.avm-res-network-virtualnetwork-subnet["${each.value.virtual_network}-${each.value.subnet}"].resource_id : null
    }
  ] : [] 

  ip_range_filter     = each.value.ip_range_filter
  enable_telemetry    = var.enable_telemetry
  tags                = var.default_tags
}
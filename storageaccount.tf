module "avm-res-storage-storageaccount" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.6.5"

  for_each = contains(var.enabled_features, "storage") ? var.storage_accounts : {}

  name                          = substr(join("", ["st", local.name_prefix, each.key, local.name_suffix, random_id.storage_account_suffix[each.key].hex]), 0, 24)
  location                      = var.location
  resource_group_name           = azurerm_resource_group.rg["${each.value.resource_group}"].name
  account_tier                  = lookup(each.value, "account_tier", null)
  account_replication_type      = lookup(each.value, "account_replication_type", null)
  account_kind                  = lookup(each.value, "account_kind", null)
  access_tier                   = lookup(each.value, "access_tier", null)
  tags                          = var.default_tags
  enable_telemetry              = var.enable_telemetry
  blob_properties               = each.value.blob_properties
  public_network_access_enabled = lookup(each.value, "public_network_access_enabled", false)
  shared_access_key_enabled     = lookup(each.value, "shared_access_key_enabled", true)
  share_properties              = each.value.share_properties
  large_file_share_enabled      = lookup(each.value, "large_file_share_enabled", false)
  containers                    = each.value.containers
  tables                        = each.value.tables
  queues                        = each.value.queues
  network_rules                 = lookup(each.value, "network_rules", null)
  is_hns_enabled                = lookup(each.value, "is_hns_enabled", null) #Hirearchical Namespace for Data Lake Gen2
  # storage_data_lake_gen2_filesystems = each.value.storage_data_lake_gen2_filesystems
}
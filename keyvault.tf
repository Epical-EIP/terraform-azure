module "avm-res-keyvault-vault" {
  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = "0.10.2"

  for_each = contains(var.enabled_features, "kv") ? var.key_vaults : {}

  name                       = substr(join("-", ["kv", local.name_prefix, each.key, local.name_suffix]), 0, 24)
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg["${each.value.resource_group}"].name
  sku_name                   = each.value.sku
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = each.value.soft_delete_retention_days
  purge_protection_enabled   = each.value.purge_protection_enabled
  tags                       = var.default_tags
  enable_telemetry           = var.enable_telemetry
  network_acls               = each.value.network_acls
  role_assignments           = each.value.role_assignments
  diagnostic_settings = { for name, setting in each.value.diagnostic_settings : name => {
    workspace_resource_id          = module.avm-res-operationalinsights-workspace[setting.workspace].resource_id
    log_analytics_destination_type = setting.log_analytics_destination_type != null ? setting.log_analytics_destination_type : "AzureDiagnostics"
    name                           = setting.name != null ? setting.name : module.naming.monitor_diagnostic_setting.name_unique
    log_categories                 = setting.log_categories
    metric_categories              = setting.metric_categories
  } }
}
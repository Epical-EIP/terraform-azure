module "avm-res-apimanagement-service" {
  source  = "Azure/avm-res-apimanagement-service/azurerm"
  version = "0.0.5"

  for_each = contains(var.enabled_features, "apim") ? var.apim_instances : {}

  name                = join("-", ["apim", local.name_prefix, each.key, local.name_suffix])
  location            = var.location
  resource_group_name = azurerm_resource_group.rg["${each.value.resource_group}"].name
  publisher_name      = each.value.publisher_name
  publisher_email     = each.value.publisher_email
  sku_name            = each.value.sku
  tags                = var.default_tags
  enable_telemetry    = var.enable_telemetry
  managed_identities  = each.value.managed_identities

  diagnostic_settings = { for name, setting in each.value.diagnostic_settings : name => {
    workspace_resource_id          = module.avm-res-operationalinsights-workspace[setting.workspace].resource_id
    log_analytics_destination_type = setting.log_analytics_destination_type != null ? setting.log_analytics_destination_type : "AzureDiagnostics"
    name                           = setting.name != null ? setting.name : module.naming.monitor_diagnostic_setting.name_unique
    log_categories                 = setting.log_categories
    metric_categories              = setting.metric_categories
  } }
}

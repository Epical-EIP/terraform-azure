module "avm-res-servicebus-namespace" {
  source  = "Azure/avm-res-servicebus-namespace/azurerm"
  version = "0.4.0"

  for_each = contains(var.enabled_features, "sb") ? var.servicebus_namespaces : {}

  enable_telemetry    = var.enable_telemetry
  name                = join("-", ["sb", local.name_prefix, each.key, local.name_suffix])
  location            = var.location
  resource_group_name = azurerm_resource_group.rg["${each.value.resource_group}"].name
  sku                 = each.value.sku
  tags                = var.default_tags
  diagnostic_settings = { for name, setting in each.value.diagnostic_settings : name => {
    workspace_resource_id          = module.avm-res-operationalinsights-workspace[setting.workspace].resource_id
    log_analytics_destination_type = setting.log_analytics_destination_type != null ? setting.log_analytics_destination_type : "AzureDiagnostics"
    name                           = setting.name != null ? setting.name : module.naming.monitor_diagnostic_setting.name_unique
    log_categories                 = setting.log_categories
    metric_categories              = setting.metric_categories
  } }
}

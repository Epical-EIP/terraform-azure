module "avm-res-operationalinsights-workspace" {
  source  = "Azure/avm-res-operationalinsights-workspace/azurerm"
  version = "0.4.2"

  for_each = contains(var.enabled_features, "log") ? var.log_analytics_workspaces : {}

  enable_telemetry                          = var.enable_telemetry
  location                                  = var.location
  resource_group_name                       = azurerm_resource_group.rg["${each.value.resource_group}"].name
  name                                      = join("-", ["log", local.name_prefix, each.key, local.name_suffix])
  log_analytics_workspace_retention_in_days = each.value.retention_in_days
  log_analytics_workspace_sku               = each.value.sku
  tags                                      = var.default_tags
  log_analytics_workspace_identity = {
    type = "SystemAssigned"
  }
}
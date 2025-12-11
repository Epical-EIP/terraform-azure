/*
resource "azurerm_user_assigned_identity" "func" {
  for_each = contains(var.enabled_features, "func") ? var.function_apps : {}

  location            = azurerm_resource_group.rg["${each.value.resource_group}"].location
  name                = join("-", ["uai", each.key, local.name_suffix])
  resource_group_name = azurerm_resource_group.rg["${each.value.resource_group}"].name
}
*/

resource "azurerm_storage_container" "this" {
  for_each           = contains(var.enabled_features, "func") ? var.function_apps : {}
  name               = each.key
  storage_account_id = module.avm-res-storage-storageaccount["${each.value.storage_account}"].resource.id
}

resource "azurerm_service_plan" "this" {
  for_each            = contains(var.enabled_features, "func") ? var.function_apps : {}
  location            = each.value.location != null ? each.value.location : var.location
  name                = join("-", ["ASP", each.key, local.name_suffix])
  os_type             = each.value.os_type
  resource_group_name = azurerm_resource_group.rg["${each.value.resource_group}"].name
  sku_name            = each.value.sku
  tags                = var.default_tags
}

module "avm-res-web-site" {
  source  = "Azure/avm-res-web-site/azurerm"
  version = "0.19.1"
  kind    = "functionapp"

  for_each = contains(var.enabled_features, "func") ? var.function_apps : {}

  name                        = join("-", ["func", local.name_prefix, each.key, local.name_suffix])
  location                    = each.value.location != null ? each.value.location : var.location
  resource_group_name         = azurerm_resource_group.rg["${each.value.resource_group}"].name
  os_type                     = azurerm_service_plan.this["${each.key}"].os_type
  service_plan_resource_id    = azurerm_service_plan.this["${each.key}"].id
  enable_telemetry            = var.enable_telemetry
  storage_account_name        = module.avm-res-storage-storageaccount["${each.value.storage_account}"].name
  fc1_runtime_name            = each.value.fc1_runtime_name
  fc1_runtime_version         = each.value.fc1_runtime_version
  function_app_uses_fc1       = each.value.function_app_uses_fc1
  functions_extension_version = each.value.functions_extension_version
  https_only                  = each.value.https_only
  instance_memory_in_mb       = each.value.instance_memory_in_mb
  storage_authentication_type = each.value.storage_authentication_type
  storage_container_endpoint  = join("", [module.avm-res-storage-storageaccount["${each.value.storage_account}"].resource.primary_blob_endpoint, each.key])
  storage_container_type      = "blobContainer"
  storage_account_access_key  = module.avm-res-storage-storageaccount["${each.value.storage_account}"].resource.primary_access_key
  # storage_user_assigned_identity_id = azurerm_user_assigned_identity.func["${each.key}"].id
  storage_uses_managed_identity = each.value.storage_uses_managed_identity
  site_config                   = each.value.site_config
  # app_settings                    = each.value.app_settings != null ? each.value.app_settings : null

  app_settings = lookup(var.function_app_environment_variables, each.key, null) != null ? { for k, v in var.function_app_environment_variables["${each.key}"] : k => v } : null

  key_vault_reference_identity_id = each.value.key_vault != null ? module.avm-res-keyvault-vault["${each.value.key_vault}"].resource_id : null
  enable_application_insights     = each.value.enable_application_insights
  application_insights = {
    workspace_resource_id = each.value.log_analytics_workspace != null ? module.avm-res-operationalinsights-workspace["${each.value.log_analytics_workspace}"].resource_id : null
  }
  virtual_network_subnet_id = each.value.virtual_network != null && each.value.subnet != null ? module.avm-res-network-virtualnetwork-subnet["${each.value.virtual_network}-${each.value.subnet}"].resource_id : null

  sticky_settings = {
    sticky1 = {
      app_setting_names = [
        "APPINSIGHTS_INSTRUMENTATIONKEY",
        "APPLICATIONINSIGHTS_CONNECTION_STRING ",
        "APPINSIGHTS_PROFILERFEATURE_VERSION",
        "APPINSIGHTS_SNAPSHOTFEATURE_VERSION",
        "ApplicationInsightsAgent_EXTENSION_VERSION",
        "XDT_MicrosoftApplicationInsights_BaseExtensions",
        "DiagnosticServices_EXTENSION_VERSION",
        "InstrumentationEngine_EXTENSION_VERSION",
        "SnapshotDebugger_EXTENSION_VERSION",
        "XDT_MicrosoftApplicationInsights_Mode",
        "XDT_MicrosoftApplicationInsights_PreemptSdk",
        "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT",
        "XDT_MicrosoftApplicationInsightsJava",
        "XDT_MicrosoftApplicationInsights_NodeJS",
      ]
      connection_string_names = null
    }
  }

  managed_identities = each.value.managed_identities
  depends_on         = [module.avm-res-storage-storageaccount]

}

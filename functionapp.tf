module "avm-res-web-site" {
  source  = "Azure/avm-res-web-site/azurerm"
  version = "0.19.1"
  kind    = "functionapp"

  for_each = contains(var.enabled_features, "func") ? var.function_apps : {}

  name                            = join("-", ["func", local.name_prefix, each.key, local.name_suffix])
  location                        = var.location
  resource_group_name             = azurerm_resource_group.rg["${each.value.resource_group}"].name
  os_type                         = azurerm_service_plan.sp["${each.value.service_plan}"].os_type
  service_plan_resource_id        = azurerm_service_plan.sp["${each.value.service_plan}"].id
  enable_telemetry                = var.enable_telemetry
  storage_account_name            = module.avm-res-storage-storageaccount["${each.value.storage_account}"].name
  fc1_runtime_name                = each.value.fc1_runtime_name
  fc1_runtime_version             = each.value.fc1_runtime_version
  function_app_uses_fc1           = each.value.function_app_uses_fc1
  functions_extension_version     = each.value.functions_extension_version
  https_only                      = each.value.https_only
  instance_memory_in_mb           = each.value.instance_memory_in_mb
  storage_authentication_type     = "SystemAssignedIdentity"
  storage_container_endpoint      = module.avm-res-storage-storageaccount["${each.value.storage_account}"].fqdn["blob"]
  storage_container_type          = "blobContainer"
  key_vault_reference_identity_id = each.value.key_vault != null ? module.avm-res-keyvault-vault["${each.value.key_vault}"].resource_id : null
  enable_application_insights     = each.value.enable_application_insights
  managed_identities               = each.value.managed_identities
}

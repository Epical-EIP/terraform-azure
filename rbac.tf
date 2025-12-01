
# Assign Key Vault RBAC Roles for Function Apps with System Assigned Managed Identity
module "keyvault_rbac_roles_function_app" {
  source  = "Azure/avm-res-authorization-roleassignment/azurerm"
  version = "0.3.0"

  for_each = contains(var.enabled_features, "kv") ? { for k, v in var.function_apps : k => v if lookup(v.managed_identities, "system_assigned", false) == true } : {}


  enable_telemetry = var.enable_telemetry
  role_assignments_azure_resource_manager = {
    "${each.key}" = {
      principal_id                     = module.avm-res-web-site["${each.key}"].system_assigned_mi_principal_id
      principal_type                   = "ServicePrincipal"
      role_definition_name             = "Key Vault Secrets User"
      scope                            = module.avm-res-keyvault-vault["${each.value.key_vault}"].resource_id
      skip_service_principal_aad_check = false
      description                      = "Automatic role assignment for Function App to access Key Vault"
    }
  }

  depends_on = [module.avm-res-keyvault-vault, module.avm-res-web-site]
}

# Assign Custom Key Vault RBAC Roles if defined in var.keyvault_rbac_roles
module "keyvault_rbac_roles_custom" {
  source  = "Azure/avm-res-authorization-roleassignment/azurerm"
  version = "0.3.0"

  for_each = contains(var.enabled_features, "kv") ? var.keyvault_rbac_roles : {}

  enable_telemetry = var.enable_telemetry
  role_assignments_azure_resource_manager = {
    "${each.key}" = {
      principal_id                     = each.value.principal_id
      principal_type                   = lookup(each.value, "principal_type", "ServicePrincipal")
      role_definition_name             = each.value.role_definition_name
      scope                            = module.avm-res-keyvault-vault["${each.value.key_vault}"].resource_id
      skip_service_principal_aad_check = lookup(each.value, "skip_service_principal_aad_check", false)
      description                      = lookup(each.value, "description", null)
    }
  }

  depends_on = [module.avm-res-keyvault-vault]
}
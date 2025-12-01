variable "keyvault_rbac_roles" {
  description = "The Key Vault RBAC Roles."
  type = map(object({
    key_vault                              = string
    role_definition_name                   = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
  default = {}
}
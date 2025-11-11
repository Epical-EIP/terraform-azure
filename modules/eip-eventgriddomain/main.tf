resource "azurerm_eventgrid_domain" "this" {

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  input_schema        = var.input_schema
  identity {
    type         = var.managed_identities.system_assigned ? "SystemAssigned" : "UserAssigned"
    identity_ids = var.managed_identities.user_assigned_resource_ids
  }
} 
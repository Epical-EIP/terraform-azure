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
  
  input_mapping_default_values {
    data_version = var.input_mapping_default_values.data_version
    event_type   = var.input_mapping_default_values.event_type
    subject      = var.input_mapping_default_values.subject
  }

  input_mapping_fields {
    data_version = var.input_mapping_fields.data_version
    event_time   = var.input_mapping_fields.event_time
    event_type   = var.input_mapping_fields.event_type
    id           = var.input_mapping_fields.id
    subject      = var.input_mapping_fields.subject
    topic        = var.input_mapping_fields.topic
  }
  
} 
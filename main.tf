# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.3.0"
  suffix  = [var.customer_abbreviation, var.environment]
}

locals {
  name_prefix = var.customer_abbreviation
  name_suffix = var.environment
}

resource "random_id" "storage_account_suffix" {
  for_each = var.storage_accounts

  byte_length = 4
}

data "azurerm_client_config" "current" {
}
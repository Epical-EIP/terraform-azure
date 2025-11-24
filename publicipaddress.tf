/*
resource "azurerm_public_ip" "this" {
  
  for_each = contains(var.enabled_features, "pip") ? var.public_ip_addresses : {}

  name                = join("-", ["pip", local.name_prefix, each.key, local.name_suffix])
  location            = azurerm_resource_group.rg["${each.value.resource_group}"].location
  resource_group_name = azurerm_resource_group.rg["${each.value.resource_group}"].name
  allocation_method   = "Static"
  tags = var.default_tags
}
*/
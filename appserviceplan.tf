resource "azurerm_service_plan" "sp" {
  for_each            = contains(var.enabled_features, "func") ? var.app_service_plans : {}
  location            = each.value.location != null ? each.value.location : var.location
  name                = join("-", ["ASP", each.key, local.name_suffix])
  os_type             = each.value.os_type
  resource_group_name = azurerm_resource_group.rg["${each.value.resource_group}"].name
  sku_name            = each.value.sku
  tags                = var.default_tags
}
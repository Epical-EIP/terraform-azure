module "avm-res-search-searchservice" {
  source  = "Azure/avm-res-search-searchservice/azurerm"
  version = "0.2.0"

  for_each = contains(var.enabled_features, "search") ? var.search_services : {}

  name                          = join("-", ["srch", each.key, local.name_suffix])
  resource_group_name           = azurerm_resource_group.rg["${each.value.resource_group}"].name
  location                      = var.location
  enable_telemetry              = var.enable_telemetry
  sku                           = each.value.sku
  semantic_search_sku           = each.value.semantical_search_sku
  allowed_ips                   = each.value.allowed_ips
  public_network_access_enabled = each.value.public_network_access_enabled
  local_authentication_enabled  = each.value.local_authentication_enabled
  managed_identities            = each.value.managed_identities

  tags = merge(var.default_tags, {
    /* Add your tags */
  })
}
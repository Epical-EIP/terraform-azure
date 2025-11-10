resource "azurerm_resource_group" "rg" {
  for_each = contains(var.enabled_features, "rg") ? toset(var.resource_groups) : []

  name = join("-", ["rg", local.name_prefix, each.value, local.name_suffix])

  location = var.location
  tags = merge(var.default_tags, {
    /* Add your tags */
  })
}

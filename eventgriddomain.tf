module "eip-eventgriddomain" {
  source = "./modules/eip-eventgriddomain"

  for_each = var.eventgrid_domains

  name                = join("-", ["evgd", local.name_prefix, each.key, local.name_suffix])
  location            = var.location
  input_schema        = each.value.input_schema
  managed_identities  = each.value.managed_identities
  resource_group_name = resource.azurerm_resource_group.rg[each.value.resource_group].name
  topics              = each.value.topics
  tags                = var.default_tags
}

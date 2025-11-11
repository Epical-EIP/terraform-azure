resource "azurerm_eventgrid_domain_topic" "this" {
  for_each = toset(var.topics)

  name                = each.key
  resource_group_name = var.resource_group_name
  domain_name         = var.name
}

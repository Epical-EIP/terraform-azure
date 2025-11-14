resource "azurerm_eventgrid_domain_topic" "this" {
  for_each = toset(var.topics)

  name                = each.value
  resource_group_name = var.resource_group_name
  domain_name         = var.name

  depends_on = [ azurerm_eventgrid_domain.this ]
}

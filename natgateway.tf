/*
resource "azurerm_nat_gateway" "this" {
  for_each = contains(var.enabled_features, "natgw") ? var.nat_gateways : {}

  name                    = join("-", ["natgw", local.name_prefix, each.key, local.name_suffix])
  location                = azurerm_resource_group.rg["${each.value.resource_group}"].location
  resource_group_name     = azurerm_resource_group.rg["${each.value.resource_group}"].name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
  tags = var.default_tags
}

*/

module "avm-res-network-natgateway" {
  source  = "Azure/avm-res-network-natgateway/azurerm"
  version = "0.2.1"
  # insert the 3 required variables here
  for_each                = contains(var.enabled_features, "natgw") ? var.nat_gateways : {}
  name                    = join("-", ["natgw", local.name_prefix, each.key, local.name_suffix])
  location                = azurerm_resource_group.rg["${each.value.resource_group}"].location
  resource_group_name     = azurerm_resource_group.rg["${each.value.resource_group}"].name
  sku_name                = each.value.sku_name
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
  enable_telemetry        = var.enable_telemetry
  tags                    = var.default_tags

  public_ips = each.value.public_ip_enabled == true ? {
    pip_1 = {
      name = join("-", ["pip", local.name_prefix, each.key, local.name_suffix])
    }
  } : null

  public_ip_configuration = each.value.public_ip_enabled == true ? {

    allocation_method    = "Static"
    ddos_protection_mode = "Disabled"
    sku                  = "Standard"
    sku_tier             = "Regional"
    zones                = ["1"]
    ip_version           = "IPv4"

  } : null
}
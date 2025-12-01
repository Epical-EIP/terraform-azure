module "avm-res-network-virtualnetwork" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.16.0"

  for_each = contains(var.enabled_features, "vnet") ? var.virtual_networks : {}

  parent_id = azurerm_resource_group.rg["${each.value.resource_group}"].id

  name     = join("-", ["vnet", local.name_prefix, each.key, local.name_suffix])
  location = var.location

  address_space = each.value.address_space

  enable_telemetry = var.enable_telemetry
  tags             = var.default_tags

}

module "avm-res-network-virtualnetwork-subnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm//modules/subnet"
  version = "0.16.0"

  for_each = { for item in flatten([for vnet_key, vnet in var.virtual_networks : [for subnet_key, subnet in vnet.subnets : {
    vnet_key         = vnet_key
    subnet_key       = subnet_key
    address_prefixes = subnet.address_prefixes
    nat_gateway      = lookup(subnet, "nat_gateway", null)
  }]]) : "${item.vnet_key}-${item.subnet_key}" => item }

  parent_id = module.avm-res-network-virtualnetwork["${each.value.vnet_key}"].resource_id

  name             = each.value.subnet_key
  address_prefixes = each.value.address_prefixes
  nat_gateway = each.value.nat_gateway != null ? {
    id = module.avm-res-network-natgateway["${each.value.nat_gateway}"].resource_id
  } : null

  delegations = [
    {
      name = "delegation1"
      service_delegation = {
        name    = "Microsoft.App/environments"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
    }
  ]
}
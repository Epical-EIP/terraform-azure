variable "virtual_networks" {
  type = map(object({
    address_space       = list(string)
    resource_group    = string
    subnets = map(object({
      address_prefixes  = list(string)
      nat_gateway       = optional(string)
    }))
  }))
}
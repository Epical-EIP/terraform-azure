variable "nat_gateways" {
  description = "The NAT Gateways."
  type = map(object({
    resource_group    = string
    sku_name          = optional(string, "Standard")
    idle_timeout_in_minutes = optional(number, 10)
    zones             = optional(list(string), ["1"])
    public_ip_enabled         = optional(bool, false)
  }))
  default = {}
}
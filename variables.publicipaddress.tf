variable "public_ip_addresses" {
  description = "A map of Public IP Addresses to create."
  type = map(object({
    resource_group   = string
    virtual_network  = string
    subnet           = string
    ip_address       = string
  }))
  default = {}
  
}
variable "app_service_plans" {
  type = map(object({
    resource_group = string
    sku            = optional(string, "FC1") # Default SKU - Flex Consumption
    os_type        = optional(string, "Linux")
    location       = optional(string)
  }))
}

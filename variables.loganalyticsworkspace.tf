variable "log_analytics_workspaces" {
  description = "The Log Analytics Workspaces."
  type = map(object({
    sku               = string
    retention_in_days = number
    resource_group    = string
  }))
  default = {}
}

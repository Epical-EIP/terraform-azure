variable "log_analytics_workspaces" {
  description = "The Log Analytics Workspaces."
  type = map(object({
    sku               = string
    retention_in_days = number
    resource_group    = string
    tags              = optional(map(string), {})
    log_analytics_workspace_internet_query_enabled = optional(bool, false) # Default disable Internet Query
  }))
  default = {}
}

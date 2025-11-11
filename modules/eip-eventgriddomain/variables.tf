variable "name" {
  description = "The name of the Event Grid Domain."
  type        = string
}

variable "location" {
  description = "The Azure location where the Event Grid Domain will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Event Grid Domain."
  type        = map(string)
  default     = {}
}

variable "input_schema" {
  description = "A input Schema for the Event Grid Domain"
  type        = string
  default     = "CloudEventSchemaV1_0"
}

variable "managed_identities" {
  description = "Managed identities configuration for the Event Grid Domain."
  type = object({
    system_assigned            = optional(bool, true) # Default enable System Assigned Identity
    user_assigned_resource_ids = optional(set(string), [])
  })
  default = { system_assigned = true }
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Event Grid Domain."
  type        = string
}

variable "topics" {
  description = "A map of Event Grid Domain Topics to create."
  type        = list(string)
  default     = []
}
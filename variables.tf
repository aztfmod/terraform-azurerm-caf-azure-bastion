variable "resource_group_name" {
  description = "(Required) Name of the resource group where to create the resource. Changing this forces a new resource to be created."
}

variable "name" {
  description = "(Required) Name for the objects created (before naming convention applied.)"
}

variable "location" {
  description = "(Required) Specifies the Azure location to deploy the resource. Changing this forces a new resource to be created."
}

variable "tags" {
  description = "(Required) Map of tags for the deployment."
}

variable "convention" {
  description = "(Required) Naming convention method to use"  
}

variable "prefix" {
  description = "(Optional) You can use a prefix to the name of the resource"
  type        = string
  default = ""
}

variable "postfix" {
  description = "(Optional) You can use a postfix to the name of the resource"
  type        = string
  default = ""
}

variable "max_length" {
  description = "(Optional) You can speficy a maximum length to the name of the resource"
  type        = string
  default = ""
}

variable "diagnostics_map" {
  description = "(Required) contains the SA and EH details for operations diagnostics"
}

variable "log_analytics_workspace" {
  description = "(Required) contains the log analytics workspace details for operations diagnostics"
}

variable "diagnostics_settings" {
  description = "(Required) configuration object describing the diagnostics"
}

variable "subnet_id" {
  description = "(Required) Subnet ID to plug Azure Bastion."
}

variable "bastion_config" {
  description = "(Required) Bastion configuration object"
}

variable "public_ip_address_id" {
  description = "(Required) ID of the Public IP address to use."
}
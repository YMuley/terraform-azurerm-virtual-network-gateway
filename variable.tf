variable "vpn_list" {
  type = list(any)
  default = []
  description = "vpn configuration list"
}

variable "resource_group_output" {
  type = map(any)
  default = {}
  description = "map of resource group"
}

variable "subnet_output" {
  type        = map(any)
  default     = {}
  description = "subnet output"
}

variable "public_ip_output" {
  type = map(any)
  default = {}
  description = "list of public ip objects"
}
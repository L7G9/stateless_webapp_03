variable "name_tag_prefix" {
  type        = string
  description = "Prefix to give all name tags of resources created by this module"
}

variable "instance_security_groups" {
  type        = list(string)
  description = "Security groups to add instances to"
}

variable "instance_subnets" {
  type        = list(string)
  description = "Subnet IDs to launch instances in"
}

variable "target_group_arns" {
  type        = list(string)
  description = "Target groups to add instances to"
}

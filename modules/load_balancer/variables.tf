variable "name_tag_prefix" {
  type        = string
  description = "Prefix to give all name tags of resources created by this module"
}

variable "security_groups" {
  type        = list(string)
  description = "List of security group ids to add the load balancer"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnet ids to add the load balancer"
}

variable "vpc" {
  type        = string
  description = "ID of VPC to create target group in"
}

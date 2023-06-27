variable "name_tag_prefix" {
  type        = string
  description = "Prefix to give all name tags of resources created by this module"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group ids to add the load balancer"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet ids to add the load balancer"
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC to create target group in"
}

variable "certificate_arn" {
  type        = string
  description = "ARN of the default SSL server certificate"
}

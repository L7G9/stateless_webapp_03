variable "name_tag_prefix" {
  type        = string
  description = "Prefix to give all name tags of resources created by this module"
  default     = "swa_03"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
}

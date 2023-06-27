variable "name_tag_prefix" {
  type        = string
  description = "Prefix to give all name tags of resources created by this module"
}

variable "hosted_zone_name" {
  type        = string
  description = "Name of hosted zone to create DNS records for"
}

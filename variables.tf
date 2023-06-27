variable "name_tag_prefix" {
  type        = string
  description = "Prefix to give all name tags of resources created by this module"
  default     = "swa-03"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
}

variable "domain_name" {
  type        = string
  description = "Name of hosted zone"
}

variable "subdomain" {
  type        = string
  description = "Subdomain to be added to domain name to create alias record in hosted zone"
  default     = "www"
}

variable "certificate_arn" {
  type        = string
  description = "ARN of a SSL certificate which has been used to validate owership of the domain name"
}

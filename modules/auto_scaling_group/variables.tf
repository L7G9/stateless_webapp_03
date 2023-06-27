variable "name_tag_prefix" {
  type        = string
  description = "Prefix to give all name tags of resources created by this module"
}

variable "instance_type" {
  type        = string
  description = "Instance type to launch"
  default     = "t2.micro"
}

variable "user_data_file_path" {
  type        = string
  description = "Script to run when launching the instance"
  default     = "./files/user-data.sh"
}

variable "minimum_number_of_instances" {
  type        = number
  description = "Minimum size of the Auto Scaling Group"
  default     = 1
}

variable "maximum_number_of_instances" {
  type        = number
  description = "Maximum size of the Auto Scaling Group"
  default     = 3
}

variable "desired_number_of_instances" {
  type        = number
  description = "Number of instances that should be running in the Auto Scaling Group"
  default     = 1
}

variable "instance_security_group_ids" {
  type        = list(string)
  description = "Security group Ids to add instances to"
}

variable "instance_subnet_ids" {
  type        = list(string)
  description = "Subnet Ids to launch instances in"
}

variable "target_group_arns" {
  type        = list(string)
  description = "Target group ARNs to add instances to"
}



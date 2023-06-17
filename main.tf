terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

module "network" {
  source = "./modules/network"

  name_tag_prefix    = var.name_tag_prefix
  availability_zones = var.availability_zones
}

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

module "security" {
  source = "./modules/security"

  name_tag_prefix = var.name_tag_prefix
  vpc_id          = module.network.vpc_id
}

module "load_balancer" {
  source = "./modules/load_balancer"

  name_tag_prefix = var.name_tag_prefix
  security_groups = [module.security.lb_security_group_id]
  subnets         = module.network.public_subnet_ids
  vpc             = module.network.vpc_id
  certificate_arn = "arn:aws:acm:eu-west-2:382801774683:certificate/643f4f71-e7d0-4e03-935f-ef6cbd8bdbd0"
}

module "auto_scaling_group" {
  source = "./modules/auto_scaling_group"

  name_tag_prefix          = var.name_tag_prefix
  instance_security_groups = [module.security.instance_security_group_id]
  instance_subnets         = module.network.private_subnet_ids
  target_group_arns        = [module.load_balancer.lb_target_group_arn]
}

module "route53" {
  source = "./modules/route53"

  name_tag_prefix = var.name_tag_prefix
  hosted_zone_name = var.domain_name
  subdomain = var.subdomain
  load_balancer_arn = module.load_balancer.lb_arn
}

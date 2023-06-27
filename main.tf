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

module "certificate" {
  source = "./modules/certificate"

  name_tag_prefix  = var.name_tag_prefix
  hosted_zone_name = var.domain_name
}

module "load_balancer" {
  source = "./modules/load_balancer"

  name_tag_prefix    = var.name_tag_prefix
  security_group_ids = [module.security.lb_security_group_id]
  subnet_ids         = module.network.public_subnet_ids
  vpc_id             = module.network.vpc_id
  certificate_arn    = module.certificate.certificate_arn
}

module "auto_scaling_group" {
  source = "./modules/auto_scaling_group"

  name_tag_prefix             = var.name_tag_prefix
  instance_security_group_ids = [module.security.instance_security_group_id]
  instance_subnet_ids         = module.network.private_subnet_ids
  target_group_arns           = [module.load_balancer.lb_target_group_arn]
}

module "route53" {
  source = "./modules/route53"

  name_tag_prefix   = var.name_tag_prefix
  hosted_zone_name  = var.domain_name
  subdomain         = var.subdomain
  load_balancer_arn = module.load_balancer.lb_arn
}

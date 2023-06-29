# Stateless WebApp #3

The 3rd part a series of projects deploying a stateless webapp on AWS using Terraform.

---

Builds on [Stateless WebApp #2](https://github.com/L7G9/stateless_webapp_02) by including an Auto Scaling Group to launch and terminate EC2 instances depending on demand.  The Auto Scaling Group and the Application Load Balancer use multiple subnets in different availability zones to achieve high availability.  A DNS validated certificate is created to enable HTTPS access to the Load Balancer.

Terraform-doc is used with a GitHub workflow to automatically generate module reference documentation.

This project is made up of 6 modules...
- [network](https://github.com/L7G9/stateless_webapp_03/blob/main/modules/network/README.md)
- [security](https://github.com/L7G9/stateless_webapp_03/blob/main/modules/security/README.md)
- [certificate](https://github.com/L7G9/stateless_webapp_03/tree/main/modules/certificate)
- [load_balancer](https://github.com/L7G9/stateless_webapp_03/tree/main/modules/load_balancer)
- [auto_scaling_group](https://github.com/L7G9/stateless_webapp_03/tree/main/modules/auto_scaling_group)
- [route53](https://github.com/L7G9/stateless_webapp_03/tree/main/modules/route53)

---

## Getting Started

### Disclaimer
This project attempts to stay within the AWS free tier as much as possible but any charges incurred while using are not the responsibility of the Author.

### Requirements
- [Terraform & AWS CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build)
- [Route53 Hosted Zone](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/CreatingHostedZone.html)

###

Clone Github repository and move into project directory.
```bash
git clone https://github.com/L7G9/stateless_webapp_03.git
cd stateless_webapp_03
```

Update terraform.auto.tfvars file in a text editor with your own values.  The variables region, availability_zones and domain_name (from your Route53 Hosted Zone) are all required as minimum.
```
region             = "eu-west-2"
availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
domain_name        = "lukegregorydev.co.uk"
subdomain          = "www"
```

Initialize the directory.
```bash
terraform init
```

Apply the configuration.
```bash
terraform apply
```

Copy URL from the outputs into web browser.
```bash
route53_alias_name = "www.lukegregorydev.co.uk"
```

Clean up.
```bash
terraform destroy
```

---

## Development Environment - Ubuntu

### Terraform-docs
Terraform-docs is used to automatically produce documentation for Terraform modules.

Install using Snap.
```bash
sudo apt update
sudo apt install snapd
sudo snap install terraform-docs
```

Can be integrated into GitHub with the following [workflow]().  After pull request or a push is made to a branch in the repository, it will push the updated documentation to the same branch.

---

# Main Module Reference

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.16 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_auto_scaling_group"></a> [auto\_scaling\_group](#module\_auto\_scaling\_group) | ./modules/auto_scaling_group | n/a |
| <a name="module_certificate"></a> [certificate](#module\_certificate) | ./modules/certificate | n/a |
| <a name="module_load_balancer"></a> [load\_balancer](#module\_load\_balancer) | ./modules/load_balancer | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_route53"></a> [route53](#module\_route53) | ./modules/route53 | n/a |
| <a name="module_security"></a> [security](#module\_security) | ./modules/security | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones | `list(string)` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Name of hosted zone | `string` | n/a | yes |
| <a name="input_name_tag_prefix"></a> [name\_tag\_prefix](#input\_name\_tag\_prefix) | Prefix to give all name tags of resources created by this module | `string` | `"swa-03"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | Subdomain to be added to domain name to create alias record in hosted zone | `string` | `"www"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_dns_name"></a> [lb\_dns\_name](#output\_lb\_dns\_name) | DNS name assigned to load balancer |
| <a name="output_route53_alias_name"></a> [route53\_alias\_name](#output\_route53\_alias\_name) | URL of alias record poiting to load balancer |
<!-- END_TF_DOCS -->

---

## Author
[@L7G9](https://www.github.com/L7G9)

---

## Acknowledgements
All these resources were used to create this project.  Thank you to all those who took the time and effort to share.
- [Udemy Ultimate AWS Certified Solutions Architect Associate SAA-C03](https://www.udemy.com/course/aws-certified-solutions-architect-associate-saa-c03/)
- [Terraform AWS getting started](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build)
- [Building an AWS Terraform VPC Step-by-Step](https://adamtheautomator.com/terraform-vpc/)
- [Terraform-docs](https://terraform-docs.io/)

---

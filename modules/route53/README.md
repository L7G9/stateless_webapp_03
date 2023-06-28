# Terraform-docs README placeholder

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_lb.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb) | data source |
| [aws_route53_zone.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hosted_zone_name"></a> [hosted\_zone\_name](#input\_hosted\_zone\_name) | Name of hosted zone to create alias record in | `string` | n/a | yes |
| <a name="input_load_balancer_arn"></a> [load\_balancer\_arn](#input\_load\_balancer\_arn) | ARN of load balancer to point alias record to | `string` | n/a | yes |
| <a name="input_name_tag_prefix"></a> [name\_tag\_prefix](#input\_name\_tag\_prefix) | Prefix to give all name tags of resources created by this module | `string` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | Subdomain of alias record name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alias_record_name"></a> [alias\_record\_name](#output\_alias\_record\_name) | Address used to reach load balancer |
<!-- END_TF_DOCS -->

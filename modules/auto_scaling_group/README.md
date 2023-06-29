# Module Auto Scaling Group
Creates an auto scaling group using a launch configuration for use with a load balancer target group.

## Example 1 - minimum variables

```
module "auto_scaling_group" {
  source = "./modules/auto_scaling_group"

  name_tag_prefix             = "my-project-"
  instance_security_group_ids = [var.instance_security_group_id]
  instance_subnet_ids         = var.private_subnet_ids
  target_group_arns           = [var.lb_target_group_arn]
}
```

## Example 2 - all variables
```
module "auto_scaling_group" {
  source = "./modules/auto_scaling_group"

  name_tag_prefix             = "my-project-"
  instance_type               = "t2.micro"
  user_data_file_path         = "./files/user-data.sh"
  minimum_number_of_instances = 1
  maximum_number_of_instances = 5
  desired_number_of_instances = 2
  instance_security_group_ids = [var.instance_security_group_id]
  instance_subnet_ids         = var.private_subnet_ids
  target_group_arns           = [var.lb_target_group_arn]
}
```

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
| [aws_autoscaling_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_desired_number_of_instances"></a> [desired\_number\_of\_instances](#input\_desired\_number\_of\_instances) | Number of instances that should be running in the Auto Scaling Group | `number` | `1` | no |
| <a name="input_instance_security_group_ids"></a> [instance\_security\_group\_ids](#input\_instance\_security\_group\_ids) | Security group Ids to add instances to | `list(string)` | n/a | yes |
| <a name="input_instance_subnet_ids"></a> [instance\_subnet\_ids](#input\_instance\_subnet\_ids) | Subnet Ids to launch instances in | `list(string)` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to launch | `string` | `"t2.micro"` | no |
| <a name="input_maximum_number_of_instances"></a> [maximum\_number\_of\_instances](#input\_maximum\_number\_of\_instances) | Maximum size of the Auto Scaling Group | `number` | `3` | no |
| <a name="input_minimum_number_of_instances"></a> [minimum\_number\_of\_instances](#input\_minimum\_number\_of\_instances) | Minimum size of the Auto Scaling Group | `number` | `1` | no |
| <a name="input_name_tag_prefix"></a> [name\_tag\_prefix](#input\_name\_tag\_prefix) | Prefix to give all name tags of resources created by this module | `string` | n/a | yes |
| <a name="input_target_group_arns"></a> [target\_group\_arns](#input\_target\_group\_arns) | Target group ARNs to add instances to | `list(string)` | n/a | yes |
| <a name="input_user_data_file_path"></a> [user\_data\_file\_path](#input\_user\_data\_file\_path) | Script to run when launching the instance | `string` | `"./files/user-data.sh"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

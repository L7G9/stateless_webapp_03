data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_launch_configuration" "main" {
  name_prefix     = "${var.name_tag_prefix}-asg-instance-"
  image_id        = data.aws_ami.amazon_linux.id
  instance_type   = var.instance_type
  user_data       = file(var.user_data_file_path)
  security_groups = var.instance_security_group_ids

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main" {
  min_size                  = var.minimum_number_of_instances
  max_size                  = var.maximum_number_of_instances
  desired_capacity          = var.desired_number_of_instances
  health_check_type         = "ELB"
  health_check_grace_period = 600
  launch_configuration      = aws_launch_configuration.main.name
  vpc_zone_identifier       = var.instance_subnet_ids
  target_group_arns         = var.target_group_arns

  tag {
    key                 = "Name"
    value               = "${var.name_tag_prefix}-main"
    propagate_at_launch = true
  }
}

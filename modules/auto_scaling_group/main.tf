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
  name_prefix     = "swa-03-"
  image_id        = data.aws_ami.amazon_linux.id
  instance_type   = "t2.micro"
  user_data       = file("./files/user-data.sh")
  security_groups = var.instance_security_groups

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main" {
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 1
  health_check_type         = "ELB"
  health_check_grace_period = 600
  launch_configuration      = aws_launch_configuration.main.name
  vpc_zone_identifier       = var.instance_subnets
  target_group_arns         = var.target_group_arns
}

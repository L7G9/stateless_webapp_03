resource "aws_lb" "main" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  tags = {
    Name = "${var.name_tag_prefix}_lb"
  }
}

resource "aws_lb_target_group" "main" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc

  health_check {
    port = 80
  }

  tags = {
    Name = "${var.name_tag_prefix}_lb_tg"
  }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.main.id
    type             = "forward"
  }

  tags = {
    Name = "${var.name_tag_prefix}_lb_listener"
  }
}

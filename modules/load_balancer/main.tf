resource "aws_lb" "main" {
  name = "${var.name_tag_prefix}-main"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  tags = {
    Name = "${var.name_tag_prefix}-main"
  }
}

resource "aws_lb_target_group" "main" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    port = 80
  }

  tags = {
    Name = "${var.name_tag_prefix}-main"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.main.arn
    type             = "forward"
  }

  tags = {
    Name = "${var.name_tag_prefix}-http"
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.main.arn
    type             = "forward"
  }

  tags = {
    Name = "${var.name_tag_prefix}-https"
  }
}

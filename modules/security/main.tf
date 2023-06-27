resource "aws_security_group" "instance" {
  description = "Allow inbound http from load balancer security and all outbound"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_tag_prefix}-instance"
  }
}

resource "aws_vpc_security_group_ingress_rule" "instance_allow_http_from_lb" {
  security_group_id = aws_security_group.instance.id

  description                  = "Allow inbound http from lb security group"
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
  referenced_security_group_id = aws_security_group.lb.id

  tags = {
    Name = "${var.name_tag_prefix}-instance-allow-http-from-lb-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "instance_allow_all" {
  security_group_id = aws_security_group.instance.id

  description = "Allow all outbound"
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  tags = {
    Name = "${var.name_tag_prefix}-instance-allow-all"
  }
}


resource "aws_security_group" "lb" {
  description = "Allow all inbound http, https and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "{$var.name_tag_prefix}-lb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "lb-allow-all-http" {
  security_group_id = aws_security_group.lb.id

  description = "Allow all inbound http"

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
  cidr_ipv4   = "0.0.0.0/0"

  tags = {
    Name = "${var.name_tag_prefix}-lb-allow-http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "lb_allow_all_https" {
  security_group_id = aws_security_group.lb.id

  description = "Allow all inbound https"

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443
  cidr_ipv4   = "0.0.0.0/0"

  tags = {
    Name = "${var.name_tag_prefix}-lb-allow-https"
  }
}

resource "aws_vpc_security_group_egress_rule" "lb_allow_all" {
  security_group_id = aws_security_group.lb.id

  description = "Allow all outbound"
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  tags = {
    Name = "${var.name_tag_prefix}-lb-allow-all"
  }
}

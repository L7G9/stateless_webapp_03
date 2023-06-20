resource "aws_security_group" "instance" {
  description = "Allow inbound http from load balancer security and all outbound"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_tag_prefix}_instance_sg"
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
    Name = "${var.name_tag_prefix}_instance_sg_ingress"
  }
}

resource "aws_vpc_security_group_egress_rule" "instance_allow_all" {
  security_group_id = aws_security_group.instance.id

  description = "Allow all outbound"
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  tags = {
    Name = "${var.name_tag_prefix}_instance_sg_egress"
  }
}


resource "aws_security_group" "lb" {
  description = "Allow all inbound http and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "{$var.name_tag_prefix}_lb_sg2"
  }
}

resource "aws_vpc_security_group_ingress_rule" "lb_allow_all_http" {
  security_group_id = aws_security_group.lb.id

  description = "Allow all inbound http"

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
  cidr_ipv4   = "0.0.0.0/0"

  tags = {
    Name = "${var.name_tag_prefix}_lb_sg_ingress_all"
  }
}

resource "aws_vpc_security_group_egress_rule" "lb_allow_all" {
  security_group_id = aws_security_group.lb.id

  description = "Allow all outbound"
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  tags = {
    Name = "${var.name_tag_prefix}_lb_sg_egress_all"
  }
}

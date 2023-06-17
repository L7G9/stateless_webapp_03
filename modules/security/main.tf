resource "aws_security_group" "lb" {
  description = "Allow ssh, http & https inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_tag_prefix}_lb_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "lb_allow_ssh" {
  security_group_id = aws_security_group.lb.id

  description = "Allow incomming ssh from anywhere"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22

  tags = {
    Name = "${var.name_tag_prefix}_lb_sg_ingress_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "lb_allow_http" {
  security_group_id = aws_security_group.lb.id

  description = "Allow incomming http from anywhere"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80

  tags = {
    Name = "${var.name_tag_prefix}_lb_sg_ingress_http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "lb_allow_https" {
  security_group_id = aws_security_group.lb.id

  description = "Allow incomming https from anywhere"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443

  tags = {
    Name = "${var.name_tag_prefix}_lb_sg_ingress_https"
  }
}

resource "aws_vpc_security_group_egress_rule" "lb_allow_all" {
  security_group_id = aws_security_group.lb.id

  description = "Allow all outgoing to anywhere"
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"

  tags = {
    Name = "${var.name_tag_prefix}_lb_sg_egress_all"
  }
}

resource "aws_security_group" "instance" {
  description = "Allow traffic to and from the lb security group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_tag_prefix}_instance_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "instance_allow_from_lb" {
  security_group_id = aws_security_group.instance.id

  description = "Allow incomming from lb security group"
  ip_protocol = "-1"
  referenced_security_group_id = aws_security_group.lb.id

  tags = {
    Name = "${var.name_tag_prefix}_instance_sg_ingress"
  }
}

resource "aws_vpc_security_group_egress_rule" "instance_allow_to_lb" {
  security_group_id = aws_security_group.instance.id

  description = "Allow outgoing to lb security group"
  ip_protocol = "-1"
  referenced_security_group_id = aws_security_group.lb.id

  tags = {
    Name = "${var.name_tag_prefix}_instance_sg_egress"
  }
}

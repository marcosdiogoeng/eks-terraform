resource "aws_security_group" "allow_ssh" {
  name        = "bastion-sg"
  description = "Allow connection inbound ssh traffic for internet and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "bastion-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "170.245.55.9/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "allow_all_ssh_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "allow_postgresql" {
  name        = "postgresql-sg"
  description = "Allow connection inbound traffic for VPC and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "postgresql-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "allow_postgresql_ipv4" {
  security_group_id = aws_security_group.allow_postgresql.id
  cidr_ipv4         = var.cidr_block
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_postgresql.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

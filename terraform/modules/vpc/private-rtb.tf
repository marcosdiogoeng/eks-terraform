resource "aws_route_table" "private_rtb_1a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_private_1a.id
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-private-rtb-1a"
  })
}

resource "aws_route_table" "private_rtb_1b" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_private_1a.id
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-private-rtb-1b"
  })
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_1a.id
  route_table_id = aws_route_table.private_rtb_1a.id
}
resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_1b.id
  route_table_id = aws_route_table.private_rtb_1b.id
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.tags, {
    Name = "public-rtb"
  })
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.public_rtb.id
}
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_1b.id
  route_table_id = aws_route_table.public_rtb.id
}
resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_1c.id
  route_table_id = aws_route_table.public_rtb.id
}
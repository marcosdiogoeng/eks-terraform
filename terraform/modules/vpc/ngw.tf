resource "aws_eip" "ngw_eip_1a" {
  domain = "vpc"

  tags = merge(var.tags, {
    Name = "${var.project_name}-ngw-eip-1a"
  })
}

resource "aws_nat_gateway" "ngw_private_1a" {
  allocation_id = aws_eip.ngw_eip_1a.id
  subnet_id     = aws_subnet.public_1a.id

  tags = merge(var.tags, {
    Name = "${var.project_name}-ngw-1a"
  })

}


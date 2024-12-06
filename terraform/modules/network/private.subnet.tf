resource "aws_subnet" "private_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 4)
  availability_zone = "${data.aws_region.current.name}a"
  tags = merge(var.tags, {
    Name = "private-1a"
  })
}

resource "aws_subnet" "private_1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 5)
  availability_zone = "${data.aws_region.current.name}b"
  tags = merge(var.tags, {
    Name = "private-1b"
  })
}

resource "aws_subnet" "private_1c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 6)
  availability_zone = "${data.aws_region.current.name}c"
  tags = merge(var.tags, {
    Name = "private-1c"
  })
}
resource "aws_subnet" "public_1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 1)
  availability_zone       = "${data.aws_region.current.name}a"
  map_public_ip_on_launch = true
  tags = merge(local.tags, {
    Name = "public-1a"
  })
}

resource "aws_subnet" "public_1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 2)
  availability_zone       = "${data.aws_region.current.name}b"
  map_public_ip_on_launch = true
  tags = merge(local.tags, {
    Name = "public-1b"
  })
}

resource "aws_subnet" "public_1c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 3)
  availability_zone       = "${data.aws_region.current.name}c"
  map_public_ip_on_launch = true
  tags = merge(local.tags, {
    Name = "public-1c"
  })
}
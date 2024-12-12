resource "aws_subnet" "private_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, 3, 3)
  availability_zone = "${data.aws_region.current.name}a"
  tags = merge(var.tags, {
    Name                              = "${var.project_name}-private-1a"
    "kubernetes.io/role/internal-elb" = 1
  })
}

resource "aws_subnet" "private_1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, 3, 4)
  availability_zone = "${data.aws_region.current.name}b"
  tags = merge(var.tags, {
    Name                              = "${var.project_name}-private-1b"
    "kubernetes.io/role/internal-elb" = 1
  })
}

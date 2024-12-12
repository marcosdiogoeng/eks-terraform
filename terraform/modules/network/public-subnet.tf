resource "aws_subnet" "public_1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr_block, 3, 0)
  availability_zone       = "${data.aws_region.current.name}a"
  map_public_ip_on_launch = true
  tags = merge(var.tags, {
    Name                     = "${var.project_name}-public-1a"
    "kubernetes.io/role/elb" = 1
  })
}

resource "aws_subnet" "public_1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr_block, 3, 1)
  availability_zone       = "${data.aws_region.current.name}b"
  map_public_ip_on_launch = true
  tags = merge(var.tags, {
    Name                     = "${var.project_name}-public-1b"
    "kubernetes.io/role/elb" = 1
  })
}

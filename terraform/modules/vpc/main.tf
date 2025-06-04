#Create the VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = "main-vpc"
  })
}

# Create the Internet Gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge(var.tags, {
    Name = "main-igw"
  })
}

# Create EIP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  depends_on = [ aws_internet_gateway.main_igw ]

  tags = merge(var.tags, {
    Name = "nat-eip"
  })
}

# Create NAT Gateway for private subnets
resource "aws_nat_gateway" "private_nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public_subnets["public_subnet_1"].id
  depends_on = [ aws_internet_gateway.main_igw, aws_subnet.public_subnets ]

  tags = merge(var.tags, {
    Name = "private-nat-gateway"
  })
}

# Create public subnets
resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnets
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, each.value + 100)
  availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = each.value
    "kubernetes.io/role/elb" = "1"
  })
}

# Create Route Table for public subnets
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id  
  }
  depends_on = [ aws_internet_gateway.main_igw ]
  tags = merge(var.tags, {
    Name = "public-route-table"
  })
}

# Create private subnets
resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnets
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]

  tags = merge(var.tags, {
    Name = each.value
    "kubernetes.io/role/internal-elb" = "1"
  })
  
}

# Create Route Table for private subnets
resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.private_nat_gateway.id
  }
  depends_on = [ aws_nat_gateway.private_nat_gateway ]
  tags = merge(var.tags, {
    Name = "private-route-table"
  })
}

#Route table associations for subnets
resource "aws_route_table_association" "public_subnets" {
  for_each = aws_subnet.public_subnets
  subnet_id = each.value.id
  route_table_id = aws_route_table.public_rtb.id

  depends_on = [ aws_subnet.public_subnets, aws_route_table.public_rtb ]
}

resource "aws_route_table_association" "private_subnets" {
  for_each = aws_subnet.private_subnets
  subnet_id = each.value.id
  route_table_id = aws_route_table.private_rtb.id

  depends_on = [ aws_subnet.private_subnets, aws_route_table.private_rtb ]
}
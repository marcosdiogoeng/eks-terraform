output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main_vpc.id  
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main_vpc.cidr_block  
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = [for subnet in aws_subnet.public_subnets : subnet.id]  
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = [for subnet in aws_subnet.private_subnets : subnet.id]  
}

output "subnet_public_1a" {
  description = "Public subnet in availability zone 1a"
  value       = aws_subnet.public_subnets["public_subnet_1"].id  
}

output "subnet_public_1b" {
  description = "Public subnet in availability zone 1b"
  value       = aws_subnet.public_subnets["public_subnet_2"].id  
}

output "subnet_public_1c" {
  description = "Public subnet in availability zone 1c"
  value       = aws_subnet.public_subnets["public_subnet_3"].id  
}

output "subnet_private_1a" {
  description = "Private subnet in availability zone 1a"
  value       = aws_subnet.private_subnets["private_subnet_1"].id  
}

output "subnet_private_1b" {
  description = "Private subnet in availability zone 1b"
  value       = aws_subnet.private_subnets["private_subnet_2"].id  
}

output "subnet_private_1c" {
  description = "Private subnet in availability zone 1c"
  value       = aws_subnet.private_subnets["private_subnet_3"].id  
}
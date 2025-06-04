variable "vpc_cidr" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added, making reference to locals.tf"
}

variable "public_subnets" {
  type        = map(number)
  description = "Map of public subnets to be created, with keys as subnet names and values as their index"
  default = {
    "public_subnet_1" = 1
    "public_subnet_2" = 2
    "public_subnet_3" = 3
  }
}

variable "private_subnets" {
  type        = map(number)
  description = "Map of private subnets to be created, with keys as subnet names and values as their index"
  default = {
    "private_subnet_1" = 1
    "private_subnet_2" = 2
    "private_subnet_3" = 3
  }
}
variable "tags" {
  type        = map(string)
  description = "Tags to be added, making reference to locals.tf"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
  default     = "factors"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_public_1a" {
  type        = string
  description = "Subnet to create bastion host AZ 1a"
}
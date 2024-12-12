variable "tags" {
  type        = map(string)
  description = "Tags to be added, making reference to locals.tf"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "subnet_public_1a" {
  type        = string
  description = "Subnet to create EKS cluste AZ 1a"
}

variable "subnet_public_1b" {
  type        = string
  description = "Subnet to create EKS cluster AZ 1b"
}
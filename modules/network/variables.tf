variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added, making reference to locals.tf"
}

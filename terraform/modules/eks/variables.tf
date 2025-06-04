variable "tags" {
  type        = map(string)
  description = "Tags to be added, making reference to locals.tf"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "public_subnets" {
  type        = set(string)
  description = "Set of public subnets to be created, with each subnet represented by its name"
}
variable "tags" {
  type        = map(string)
  description = "Tags to be added, making reference to locals.tf"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "oidc" {
  type        = string
  description = "HTTPS URL from oidc provider of the EKS cluster"
}

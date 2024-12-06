variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
  default     = "10.0.0.0/16"
}

variable "environment" {
  type = string
  description = "Enviroment for deploy (dev, stagin, prod, etc.)"
  validation {
    condition     = contains(["development", "stagin", "production"], var.environment)
    error_message = "O ambiente deve ser 'development', 'stagin' ou 'production'."
  }
}

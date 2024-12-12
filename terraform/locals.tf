locals {

  tags = {
    Department   = "devops"
    Organization = "waycarbon"
    Environment  = var.environment
    ManagedBy    = "terraform"

  }
}
locals {

  tags = {
    Department   = "devops"
    Organization = "WayCarbon"
    Project      = "EKS"
    Environment  = var.environment
    ManagedBy    = "terraform"

  }
}
variable "tags" {
  type        = map(string)
  description = "Tags to be added, making reference to locals.tf"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
  default     = "factors"
}

variable "subnet_private_1a" {
  type        = string
  description = "Subnet to create EKS Managed Node Group AZ 1a"
}

variable "subnet_private_1b" {
  type        = string
  description = "Subnet to create EKS Managed Node Group AZ 1b"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the security group"

}

variable "factors_rds" {
  type = object({
    allocated_storage    = number
    db_name              = string
    storage_type         = string
    engine               = string
    engine_version       = string
    instance_class       = string
    identifier           = string
    parameter_group_name = string
    skip_final_snapshot  = bool
    publicly_accessible  = bool
  })

  default = {
    allocated_storage    = 20
    db_name              = "factors"
    storage_type         = "gp2"
    engine               = "postgres"
    engine_version       = "17.1"
    instance_class       = "db.t4g.micro"
    identifier           = "factors"
    parameter_group_name = "default.postgres17"
    skip_final_snapshot  = true
    publicly_accessible  = false
  }
}
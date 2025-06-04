variable "tags" {
  type        = map(string)
  description = "Tags to be added, making reference to locals.tf"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "environment" {
  type        = string
  description = "Enviroment for deploy (development, staging, production, etc.)"
}

variable "private_subnets" {
  type = set(string)
  description = "Set of private subnets to be created, with each subnet represented by its name"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS Cluster"
}

variable "instance_number" {
  type = object({
    development = number
    staging     = number
    production  = number
  })

  description = "Number of instances node groups to create"

  default = {
    development = 1
    staging     = 1
    production  = 2
  }
}

variable "instance_type" {
  type = object({
    development = string
    staging     = string
    production  = string
  })

  description = "Instance types associated with the EKS Node Group"

  default = {
    development = "t3.medium"
    staging     = "t3.medium"
    production  = "t3.xlarge"
  }
}
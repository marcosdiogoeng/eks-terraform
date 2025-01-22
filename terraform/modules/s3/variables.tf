variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket for factors-repository"
  default     = "factors-bucket"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added, making reference to locals.tf"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
  default     = "factors"
}
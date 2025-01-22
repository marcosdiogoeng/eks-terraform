resource "aws_s3_bucket" "factors_bucket" {
  bucket = var.bucket_name

  tags = merge(var.tags, {
    Name    = "factors-repository-bucket"
    Project = var.project_name
  })
}

resource "aws_s3_bucket_versioning" "versioning_factors_bucket" {
  bucket = aws_s3_bucket.factors_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
locals {
  credentials = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)
}
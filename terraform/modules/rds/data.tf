data "aws_secretsmanager_secret" "db_credentials" {
  name = "dev/factors/backend"
}

data "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = data.aws_secretsmanager_secret.db_credentials.id
}
resource "aws_db_instance" "factors" {
  allocated_storage      = var.factors_rds.allocated_storage
  db_name                = var.factors_rds.db_name
  storage_type           = var.factors_rds.storage_type
  engine                 = var.factors_rds.engine
  engine_version         = var.factors_rds.engine_version
  instance_class         = var.factors_rds.instance_class
  identifier             = var.factors_rds.identifier
  username               = local.credentials.username
  password               = local.credentials.password
  parameter_group_name   = var.factors_rds.parameter_group_name
  skip_final_snapshot    = var.factors_rds.skip_final_snapshot
  publicly_accessible    = var.factors_rds.publicly_accessible
  db_subnet_group_name   = aws_db_subnet_group.factors.id
  vpc_security_group_ids = [aws_security_group.allow_postgresql.id]

  tags = merge(var.tags, {
    Name = "${var.project_name}-rds"
  })

}

resource "aws_db_subnet_group" "factors" {
  name       = "${var.project_name}-rds-subnet-group"
  subnet_ids = [var.subnet_private_1a, var.subnet_private_1b]
  tags       = var.tags

}

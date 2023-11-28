resource "aws_db_instance" "rds" {
  identifier             = var.identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  storage_encrypted =  false

  username               = var.username
  password               = var.password

  port = 5432
  multi_az = false

  vpc_security_group_ids = var.database_sg_id
  db_subnet_group_name   = var.db_subnet_group_name
  enabled_cloudwatch_logs_exports = ["postgresql"]
  parameter_group_name = var.parameter_group_name

  skip_final_snapshot = true
  deletion_protection = false
  delete_automated_backups = true
}

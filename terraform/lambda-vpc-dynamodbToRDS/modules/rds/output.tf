output "db_host" {
  value = aws_db_instance.rds.address
}

output "db_username" {
  value = aws_db_instance.rds.username
}

output "db_password" {
  value = aws_db_instance.rds.password
}

output "db_name" {
  value = aws_db_instance.rds.engine
}

output "db_port" {
  value = aws_db_instance.rds.port
}
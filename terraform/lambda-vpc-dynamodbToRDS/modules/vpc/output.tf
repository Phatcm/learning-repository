
output "database_group_name" {
    value = aws_db_subnet_group.database_group.name
}

output "database_sg_id" {
    value = aws_security_group.database_sg.id
}
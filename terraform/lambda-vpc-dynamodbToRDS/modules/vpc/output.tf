
output "database_group_name" {
    value = module.vpc.database_subnet_group_name
}

output "database_sg_id" {
    value = module.security_group.security_group_id
}

output "database_pg_name" {
    value = aws_db_parameter_group.parameter_group.name
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "security_group_ids" {
  value = [module.security_group.security_group_id]
}
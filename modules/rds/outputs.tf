output "postgres_db_security_group_id" {
  value       = aws_security_group.postgres_db_sg.id
  description = "Security Group ID for RDS PostgreSQL Database"
}

output "rds_endpoint" {
  value       = aws_db_instance.postgresql.endpoint
  description = "RDS PostgreSQL Endpoint"
}

output "rds_port" {
  value       = aws_db_instance.postgresql.port
  description = "RDS PostgreSQL Port"
}

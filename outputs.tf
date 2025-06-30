# Outputs for the Terraform configuration

output "api_gateway_url" {
  value       = module.api_gateway.api_gateway_url
  description = "API Gateway endpoint URL"
}

output "bastion_public_ip" {
  value       = module.bastion.bastion_public_ip
  description = "Public IP of the Bastion Host"
}

output "rds_endpoint" {
  value       = module.rds.rds_endpoint
  description = "RDS PostgreSQL Endpoint"
}

output "redis_endpoint" {
  value       = module.redis.redis_endpoint
  description = "Redis Endpoint"
}

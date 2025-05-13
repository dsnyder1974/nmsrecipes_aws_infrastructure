variable "environment_name" {
  type        = string
  description = "Environment name, e.g., dev, staging, prod"
}

variable "db_username" {
  description = "RDS username from Secrets Manager"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "RDS password from Secrets Manager"
  type        = string
  sensitive   = true
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "lambda_security_group_id" {
  type        = string
  description = "Security group ID of the Lambda function"
}

variable "bastion_security_group_id" {
  type        = string
  description = "Security group ID of the Bastion host"
}

variable "vpc_id" {
  description = "VPC ID to associate with the Lambda security group"
  type        = string
}

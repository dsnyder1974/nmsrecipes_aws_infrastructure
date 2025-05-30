variable "environment_name" {
  type        = string
  description = "Environment name (dev, staging, prod)"
}


variable "function_name" {
  type        = string
  description = "Name of the Lambda function"
}

variable "route_key" {
  type        = string
  description = "Route key for the API Gateway route"
}


variable "db_endpoint" {
  type        = string
  description = "The RDS database endpoint"
}

variable "db_port" {
  type        = number
  description = "Port used to connect to the DB"
  default     = 5432
}


variable "vpc_id" {
  description = "VPC ID to associate with the Lambda security group"
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs to associate with Lambda"
}


variable "lambda_sg_id" {
  type        = string
  description = "Security group ID for the Lambda function"
}

variable "lambda_api_id" {
  type        = string
  description = "Name of the API Gateway"
}

variable "lambda_execution_role_arn" {
  type        = string
  description = "Name of the Lambda execution role"
}

variable lambda_api_execution_arn {
  type        = string
  description = "The execution ARN of the API Gateway"
}

variable "layers" {
  description = "Lambda layers to attach"
  type        = list(string)
  default     = []
}

variable "lambda_api_dependency" {
  type        = any
  description = "Dummy dependency to enforce apply order for API Gateway"
}

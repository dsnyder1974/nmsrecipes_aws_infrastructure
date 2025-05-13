variable "environment_name" {
  type        = string
  description = "Environment name (dev, staging, prod)"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs to associate with Lambda"
}

variable "vpc_id" {
  description = "VPC ID to associate with the Lambda security group"
  type        = string
}

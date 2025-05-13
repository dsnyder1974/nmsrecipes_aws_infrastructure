variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for the VPC endpoint"
}

variable "lambda_sg_id" {
  type        = string
  description = "Security group ID for the Lambda"
}

variable "aws_region" {
  type        = string
  description = "AWS region for the Secrets Manager endpoint"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

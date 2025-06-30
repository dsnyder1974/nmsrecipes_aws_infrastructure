variable "lambda_sg_id" {
  type        = string
  description = "Security group ID for the Lambda function"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the Redis instance will be deployed"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs where the Redis instance will be deployed"
}

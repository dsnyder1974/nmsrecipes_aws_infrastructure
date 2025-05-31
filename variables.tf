variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "environment_name" {
  description = "Name of the environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "my_ip_address" {
  description = "IP address to allow pgAdmin access temporarily to the RDS instance"
  type        = string
}

variable "public_key_path" {
  description = "Path to public SSH key file"
  type        = string
  default     = ""
}

variable "allowed_origins" {
  description = "Comma-separated list of allowed origins for CORS"
  type        = string
  default     = "http://localhost:3000"
}

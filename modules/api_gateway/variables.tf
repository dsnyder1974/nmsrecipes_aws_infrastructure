variable "environment_name" {
  type        = string
  description = "Environment name (dev, staging, prod)"
}

variable "allowed_origins" {
  description = "List of allowed origins for CORS"
  type        = list(string)
}
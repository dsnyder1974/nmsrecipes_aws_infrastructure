variable "environment_name" {
  type        = string
  description = "Environment name (dev, staging, prod)"
}

variable "public_key_path" {
  type        = string
  description = "Path to the public key for SSH access"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the bastion host"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the bastion host"
}

variable "my_ip_address" {
  type        = string
  description = "Bastion IP address for SSH access"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

##################################
# Redis Module
##################################
# This module defines resources for a Redis instance, including security groups.

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "nms-redis-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "NMS Redis Subnet Group"
  }
}

resource "aws_security_group" "redis_sg" {
  name        = "nms-redis-sg"
  description = "Allow access to Redis from Lambda"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    security_groups = [var.lambda_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elasticache_cluster" "nms_redis" {
  cluster_id           = "nms-redis"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids   = [aws_security_group.redis_sg.id]

  tags = {
    Name = "NMS Redis"
  }
}

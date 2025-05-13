##################################
# Secrets Manager Module
##################################
# This module creates a VPC endpoint for Secrets Manager.
# It allows Lambda functions to access Secrets Manager securely within the VPC.

resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.secretsmanager"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.subnet_ids
  security_group_ids = [
    var.lambda_sg_id
  ]
  private_dns_enabled = true

  tags = {
    Name = "secretsmanager-endpoint"
  }
}

resource "aws_security_group_rule" "lambda_https_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = var.lambda_sg_id
  cidr_blocks       = ["10.0.0.0/16"]
}

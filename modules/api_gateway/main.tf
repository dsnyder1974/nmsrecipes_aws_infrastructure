##################################
# API Gateway HTTP API
##################################
# This module creates the base AWS API Gateways that integrate with Lambdas

resource "aws_apigatewayv2_api" "lambda_api" {
  name          = "${var.environment_name}-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "api_stage" {
  api_id      = aws_apigatewayv2_api.lambda_api.id
  name        = "dev"
  auto_deploy = true
}

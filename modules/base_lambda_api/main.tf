##################################
# Base Lambda API Module
##################################
# This abstract module sets up a basic AWS Lambda function and API Gateway integration.
# It is designed to be used as a base for more complex Lambda functions and APIs.

resource "aws_lambda_function" "this" {
  function_name = var.function_name
  handler       = "index.handler"
  runtime       = "nodejs22.x"

  role = var.lambda_execution_role_arn

  filename = "placeholder_lambda.zip"

  timeout     = 10
  memory_size = 128

  layers = var.layers

  environment {
    variables = merge(
      {
        DB_HOST = var.db_endpoint
        DB_PORT = var.db_port
      },
      var.additional_environment_variables
    )
  }

  vpc_config {
    subnet_ids = var.subnet_ids
    security_group_ids = [
      var.lambda_sg_id
    ]
  }
}

resource "aws_apigatewayv2_integration" "this" {
  api_id                 = var.lambda_api_id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.this.arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "this" {
  api_id    = var.lambda_api_id
  route_key = var.route_key
  target    = "integrations/${aws_apigatewayv2_integration.this.id}"
}

resource "aws_lambda_permission" "allow_api_invoke_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.lambda_api_execution_arn}/*/*"

  depends_on = [var.lambda_api_dependency]
}

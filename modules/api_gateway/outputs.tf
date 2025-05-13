output "lambda_api_id" {
  value       = aws_apigatewayv2_api.lambda_api.id
  description = "The ID of the API Gateway"
}

output "api_gateway_url" {
  value       = aws_apigatewayv2_api.lambda_api.api_endpoint
  description = "API Gateway endpoint URL for accessing the Lambda function"
}

output lambda_api_execution_arn {
  value = aws_apigatewayv2_api.lambda_api.execution_arn
  description = "The execution ARN of the API Gateway"
}

output "api_dependency" {
  value = aws_apigatewayv2_api.lambda_api
  description = "API Gateway dependency for the Lambda permissions"
}

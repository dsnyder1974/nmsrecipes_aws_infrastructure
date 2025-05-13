output "lambda_security_role_arn" {
  value = aws_iam_role.lambda_execution_role.arn
}

output "lambda_sg_id" {
  value = aws_security_group.lambda_sg.id
}
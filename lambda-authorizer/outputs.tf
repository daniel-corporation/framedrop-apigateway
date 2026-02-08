output "authorizer_lambda_invoke_arn" {
  description = "ARN de invocação da Lambda Authorizer"
  value       = aws_lambda_function.authorizer.invoke_arn
}
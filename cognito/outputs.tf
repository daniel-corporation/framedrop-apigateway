output "cognito_user_pool_id" {
  description = "User pool ID"
  value       = aws_cognito_user_pool.pool.id
}

output "cognito_machine_client_id" {
  description = "Machine client ID"
  value       = aws_cognito_user_pool_client.machine_client.id
}

output "cognito_machine_client_secret" {
  description = "Machine client secret"
  value       = aws_cognito_user_pool_client.machine_client.client_secret
  sensitive   = true
}

output "cognito_token_endpoint" {
  description = "URL do endpoint para solicitar o token OAuth2."
  value       = "https://${aws_cognito_user_pool_domain.domain.domain}.auth.us-east-1.amazoncognito.com/oauth2/token"
}
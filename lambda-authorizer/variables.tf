variable "user_pool_id" {
  description = "ID do User Pool do Cognito"
  type        = string
}

variable "client_id" {
  description = "ID do App Client do Cognito"
  type        = string
}

variable "api_execution_arn" {
  description = "ARN de execução da API Gateway para permissões"
  type        = string
}
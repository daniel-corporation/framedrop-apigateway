variable "authorizer_lambda_invoke_arn" {
  description = "ARN de invocação da Lambda Authorizer (vinda do módulo authorizer)"
  type        = string
}

variable "api_name" {
  description = "Nome da API no API Gateway"
  type        = string
  default     = "framedrop-upload-api"
}

variable "stage_name" {
  description = "Nome do estágio de deploy (ex: prod, dev, stg)"
  type        = string
  default     = "prod"
}

variable "app_service_url" {
  description = "DNS do Load Balancer (ALB)"
  type        = string
}
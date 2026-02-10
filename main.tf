module "cognito" {
  source                = "./cognito"
  cognito_domain_prefix = "framedrop-uplpad-videos"
}

module "lambda-authorizer" {
  source       = "./lambda-authorizer"
  user_pool_id = module.cognito.cognito_user_pool_id
  client_id    = module.cognito.cognito_machine_client_id
  api_execution_arn = module.api_gateway.api_execution_arn
}

module "api_gateway" {
  source                       = "./api-gateway/infra"
  authorizer_lambda_invoke_arn = module.lambda-authorizer.authorizer_lambda_invoke_arn
  app_service_url              = module.vpc_link.nlb_dns_name
  vpc_link_id                  = module.vpc_link.vpc_link_id
}

module "vpc_link" {
  source = "./vpc-link"
}
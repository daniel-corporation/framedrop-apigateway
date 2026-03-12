resource "aws_api_gateway_rest_api" "api" {
  name = var.api_name
  binary_media_types = ["multipart/form-data"]
  body = templatefile("${path.module}/../open-api/openapi-bundled.yaml", {
    authorizer_lambda_invoke_arn = var.authorizer_lambda_invoke_arn
    alb_dns_name                 = var.app_service_url
  })
  
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    redeployment = sha1(aws_api_gateway_rest_api.api.body)
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = var.stage_name
}

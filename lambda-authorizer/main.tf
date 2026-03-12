resource "aws_lambda_function" "authorizer" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "framedrop-lambda-authorizer"
  role          = data.aws_iam_role.lab_role.arn
  handler       = "authorizer.handler"
  runtime       = "nodejs20.x"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      USER_POOL_ID = var.user_pool_id
      CLIENT_ID    = var.client_id
    }
  }
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.authorizer.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_execution_arn}/*/*"

  depends_on = [aws_lambda_function.authorizer]
}
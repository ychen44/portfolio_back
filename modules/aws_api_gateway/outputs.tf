output "api_gateway_execution_arn" {
  description = "execution arn of apigateway used in lambda permission."

  value = aws_api_gateway_rest_api.api.execution_arn
}
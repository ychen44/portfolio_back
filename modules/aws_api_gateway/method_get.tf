resource "aws_api_gateway_resource" "resource_get" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = var.resource_get_path
}

resource "aws_api_gateway_method" "method_get_templates" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource_get.id
  api_key_required = false
  http_method   = "GET"
  authorization = "NONE"
  # request_parameters            = {"method.request.path.proxy" = true}
}


resource "aws_api_gateway_integration" "integration_get" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource_get.id
  http_method             = aws_api_gateway_method.method_get_templates.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_get_templates_invoke_arn

  depends_on = [var.lambda_get_templates_invoke_arn]
}


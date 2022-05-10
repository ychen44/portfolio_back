resource "aws_api_gateway_resource" "resource_post" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = var.resource_post_path
}

resource "aws_api_gateway_method" "method_post" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource_post.id
  api_key_required = false
  http_method   = "POST"
  authorization = "NONE"
  # request_parameters            = {"method.request.path.proxy" = true}
}


resource "aws_api_gateway_integration" "integration_post" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource_post.id
  http_method             = aws_api_gateway_method.method_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_post_inquiry_invoke_arn

  depends_on = [var.lambda_post_inquiry_invoke_arn]
}


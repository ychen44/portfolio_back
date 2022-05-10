# resource "aws_api_gateway_domain_name" "api_gateway_domain" {
#   domain_name              = var.domain_name
#   regional_certificate_arn = var.acm_cert_arn

#   endpoint_configuration {
#     types = ["REGIONAL"]
#   }
# }

resource "aws_api_gateway_rest_api" "api" {
  name = var.rest_api_name
  description = var.apigateway_description
  endpoint_configuration {
    types = ["REGIONAL"]
  }

  # body = jsonencode({
  #   openapi = "3.0.1"
  #   info = {
  #     title   = var.rest_api_name
  #     version = "1.0"
  #   }
  #   paths = {
  #     (var.resource_post_path) = {
  #       any = {
  #         x-amazon-apigateway-integration = {
  #           httpMethod           = "POST"
  #           payloadFormatVersion = "1.0"
  #           type                 = "aws"
  #           uri                  = "arn:aws:lambda:us-east-1:124394812104:function:test"
  #         }
  #       }
  #     }
  #   }
  # })
}
resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = var.stage_name
}
resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  depends_on = [
      aws_api_gateway_resource.proxy,
      aws_api_gateway_method.proxy,

      aws_api_gateway_integration.integration,

      aws_api_gateway_resource.resource_post,
      aws_api_gateway_method.method_post,

      aws_api_gateway_integration.integration_post,
      aws_api_gateway_integration_response.options_integration_response,
      aws_api_gateway_integration.options_integration, 

      aws_api_gateway_integration.integration_get,
      aws_api_gateway_resource.resource_get,
      aws_api_gateway_method.method_get_templates,
      ]

  triggers = {
    # NOTE: The configuration below will satisfy ordering considerations,
    #       but not pick up all future REST API changes. More advanced patterns
    #       are possible, such as using the filesha1() function against the
    #       Terraform configuration file(s) or removing the .id references to
    #       calculate a hash against whole resources. Be aware that using whole
    #       resources will show a difference after the initial implementation.
    #       It will stabilize to only change when resources change afterwards.
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.proxy.id,
      aws_api_gateway_method.proxy.id,
      aws_api_gateway_integration.integration.id,
      aws_api_gateway_resource.resource_post.id,
      aws_api_gateway_method.method_post.id,
      aws_api_gateway_integration.integration_post.id, 
      aws_api_gateway_integration_response.options_integration_response,
      aws_api_gateway_integration.options_integration,

      aws_api_gateway_integration.integration_get,
      aws_api_gateway_resource.resource_get,
      aws_api_gateway_method.method_get_templates,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_api_gateway_method_settings" "general_settings" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = aws_api_gateway_stage.stage.stage_name
  method_path = "*/*"

  settings {
    # Enable CloudWatch logging and metrics
    metrics_enabled        = true
    data_trace_enabled     = true
    logging_level          = "INFO"

    # Limit the rate of calls to prevent abuse and unwanted charges
    throttling_rate_limit  = 100
    throttling_burst_limit = 50
  }
}


# resource "aws_api_gateway_api_key" "api_key" {
#   name = var.api_key_name
# }

# resource "aws_api_gateway_usage_plan" "key_usage_plan" {
#   name = var.apikey_usage_plan_name

#   depends_on = [
#       aws_api_gateway_stage.stage
#       ]

#   api_stages {
#     api_id = aws_api_gateway_rest_api.api.id
#     stage  = aws_api_gateway_stage.stage.stage_name
#   }
# }

# resource "aws_api_gateway_usage_plan_key" "usage_plan_key" {
#   key_id        = aws_api_gateway_api_key.api_key.id
#   key_type      = "API_KEY"
#   usage_plan_id = aws_api_gateway_usage_plan.key_usage_plan.id
# }
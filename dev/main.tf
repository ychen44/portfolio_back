module "s3_buckets" {
  source = "../modules/aws_s3"
  aws_region = var.aws_region
  s3_config = var.s3_config

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-s3" })

  )

}
module "acm_certificate" {
  source = "../modules/aws_acm_certificate"
  domain_name = var.domain_name
  subject_alternative_names = var.subject_alternative_names

   tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-acm" })
  )

}

module "api_gateway" {
  source = "../modules/aws_api_gateway"

  rest_api_name = var.rest_api_name
  apigateway_description = "Api Gateway for ${var.company} in the ${var.environment} enviroment"
  api_gateway_iam_role = var.api_gateway_iam_role

  resource_post_path = var.resource_post_path
  resouce_any_path = var.resouce_any_path

  resource_get_path = var.resource_get_path

  stage_name = var.stage_name

  api_key_name = "${var.company}_${var.environment}_api_key"
  apikey_usage_plan_name = "${var.company}_${var.environment}_api_usage_plan"

  lambda_post_inquiry_invoke_arn = module.portfolio_rest_apis.lambda_post_inquiry_invoke_arn
  lambda_get_templates_invoke_arn = module.portfolio_rest_apis.lambda_get_templates_invoke_arn

}

module "sns_inquiry_topic" {
  source = "../modules/aws_sns"
  default_sender_id = var.default_sender_id
  default_sms_type = var.default_sms_type
  # delivery_status_success_sampling_rate = var.delivery_status_success_sampling_rate
  monthly_spend_limit = var.monthly_spend_limit
  subscriptions = var.subscriptions
  topic_display_name = var.topic_display_name
  topic_name = var.topic_name
}

module "portfolio_rest_apis" {
  source                    = "../modules/rest_api"
  compatible_runtimes       = var.compatible_runtimes
  layer_name                = var.layer_name
  api_gateway_arn           = module.api_gateway.api_gateway_execution_arn
  s3_lambda_rest_bucket_id  = var.s3_config[0]["bucket_name"]
  lambda_post_inquiry_name    = "${var.company}_${var.environment}_${var.lambda_post_inquiry_name}"
  lambda_get_templates_name   = "${var.company}_${var.environment}_get_templates"
  sns_topic_arn             = module.sns_inquiry_topic.topic_arn
  lambda_api_role_name      = "${var.company}_${var.environment}_lambda_api_role"

  lambda_depends_on = module.s3_buckets.buckets_arn_list


}


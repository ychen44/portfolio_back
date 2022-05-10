company     = "portfolio"
environment = "dev"
aws_region  = "us-east-1"

#s3-buckets
s3_config = [
    {
      bucket_name = "portfolio-lambda-functions"
      force_destroy = true
    }
  ]



# acm 
domain_name = "yachen.link"
subject_alternative_names = ["www.yachen.link"]

#api-gateway
rest_api_domain_name = "yachen.link"
rest_api_name        = "portfolio-api-gateway"

resouce_any_path      = "all"
resource_post_path    = "inquiry"
resource_get_path    = "templates"
stage_name = "dev"

api_gateway_iam_role = "api_gateway_cw_global_role"

#sns_topic

default_sender_id = "portfolio"
default_sms_type = "Transactional"
# delivery_status_success_sampling_rate = var.delivery_status_success_sampling_rate
monthly_spend_limit = 1
subscriptions = ["ychen0404@icloud.com"]
topic_display_name = "portfolio"
topic_name = "inquiries"

# lambdas 
compatible_runtimes=[ "python3.8"]
layer_name = "portfolio_lambda_layers"
lambda_post_inquiry_name = "post_inquiry"

output "apigateway_execution_arn" {
  description = "execution arn of apigateway used in lambda permission."

  value = module.api_gateway.api_gateway_execution_arn
}

# output "s3_bucket_names_object" {
#   value = module.s3_buckets.buckets_name_objects[each.key]
# }

# output "s3_bucket_names_list" {
#   value = module.s3_buckets.buckets_name_list
# }

output "s3_buckets_name_objects" {
  value = module.s3_buckets.buckets_name_objects 
  
}
output "s3_buckets_name_list" {
  value = module.s3_buckets.buckets_name_list
}

output "s3_buckets_arn_objects" {
  value = module.s3_buckets.buckets_arn_objects 
  
}
output "s3_buckets_arn_list" {
  value = module.s3_buckets.buckets_arn_list
}

output "dev_lambda_post_inquiry_invoke_arn" {
  description = "the arn of lambda post inqury"

  value = module.portfolio_rest_apis.lambda_post_inquiry_invoke_arn
}

output "dev_lambda_post_inquiry_arn" {
  description = "the arn of lambda post inqury"

  value = module.portfolio_rest_apis.lambda_post_inquiry_arn
}
variable "compatible_runtimes" {
  type    = list(string)
  default = ["python3.9", "python3.8", "python3.7"]
}

variable "layer_name" {
  description = "Name of the lambda layer"
  type        = string
  default     = "portfolio_http_responses"
}

variable "lambda_post_inquiry_name" {
  description = "Name of the lambda layer"
  type        = string
  default     = "name of the inquiry function"
}

variable "s3_lambda_rest_bucket_id" {
  description = "Name of the s3 bucket that holds all lambda funciton"
  type        = string
}

variable "api_gateway_arn" {
  description = "arn of the apigateway"
  type        = string
}


variable "sns_topic_arn" {
  description = "Arn of the sns topic"
  type        = string
}

variable "lambda_depends_on" {
  type    = any
  default = []
}

variable "lambda_api_role_name" {
  description = "name of lmabda api role"
  type        = string
}

variable "lambda_get_templates_name" {
  description = "name of lambda function"
  type        = string
}
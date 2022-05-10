# apigateway
variable "rest_api_name" {
  type        = string
  description = "apiname"
}

variable "apigateway_description" {
  type        = string
  description = "apigateway descrption"
}

variable "resource_post_path" {
  type        = string
  description = "api path"
}
variable "resouce_any_path" {
  type        = string
  description = "api path"
}

variable "stage_name" {
  type        = string
  description = "stage name"
}

variable "lambda_post_inquiry_invoke_arn" {
  type        = any
  description = "apigateway dependency"
}

variable "api_key_name" {
  type        = string
  description = "api key name"
}

variable "apikey_usage_plan_name" {
  type        = string
  description = "name os useage plan"
}

variable "api_gateway_iam_role" {
  type        = string
  description = "api_gateway cloudwatch role"
}


variable "resource_get_path" {
  type        = string
  description = "api path"
}

variable "lambda_get_templates_invoke_arn" {
  type        = any
  description = "apigateway dependency"
}
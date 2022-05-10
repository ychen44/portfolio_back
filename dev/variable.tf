variable "company" {
  type        = string
  description = "Company to be used on all the resources as identifier."
}

variable "environment" {
  type        = string
  description = "Environment to be used on all the resources as identifier."
}

variable "aws_region" {
  type        = string
  description = "Region to deploy resources into."
}

locals {
  prefix = "${var.company}-${var.environment}"
  common_tags = {
    Enviroment = var.environment
    company    = var.company
    ManagedBy  = "Terraform"
  }

}

# s3 buckets
variable "s3_config" {
  type = list(object({
    bucket_name = string
    force_destroy = bool
  }))
  default = [
    {
      bucket_name = "test"
      force_destroy = true
    }
  ]
}


#acm 
variable "domain_name" {
  type        = string
  description = "domain name"
}

variable "subject_alternative_names" {
  type        = list
  description = "alternative domain names"
}


# api-gateway
variable "rest_api_domain_name" {
  default     = "portfolio.com"
  description = "Domain name of the API Gateway REST API for self-signed TLS certificate"
  type        = string
}

variable "rest_api_name" {
  default     = "api-gateway-rest-api-openapi-example"
  description = "Name of the API Gateway REST API (can be used to trigger redeployments)"
  type        = string
}

variable "resource_post_path" {
  description = "Path to create in the API Gateway REST API (can be used to trigger redeployments)"
  type        = string
}
variable "resouce_any_path" {
  type        = string
  description = "api path"
}

variable "stage_name" {
  type        = string
  description = "stage name"
}
variable "api_gateway_iam_role" {
  type        = string
  description = "api_gateway cloudwatch role"
}

#sns-topic
variable "default_sender_id" {
  description = "A custom ID, such as your business brand, displayed as the sender on the receiving device. Support for sender IDs varies by country."
  type        = string
  default     = ""
}

variable "default_sms_type" {
  description = "Promotional messages are noncritical, such as marketing messages. Transactional messages are delivered with higher reliability to support customer transactions, such as one-time passcodes."
  type        = string
  default     = "Promotional"
}


# variable "delivery_status_success_sampling_rate" {
#   description = "Default percentage of success to sample."
#   type        = number
#   default     = 0
# }

variable "monthly_spend_limit" {
  description = "The maximum amount to spend on SMS messages each month. If you send a message that exceeds your limit, Amazon SNS stops sending messages within minutes."
  type        = number
  default     = 1
}

variable "subscriptions" {
  description = "List of telephone numbers to subscribe to SNS."
  type        = list(string)
  default     = []
}

variable "topic_display_name" {
  description = "Display name of the AWS SNS topic."
  type        = string
  default     = ""
}

variable "topic_name" {
  description = "Name of the AWS SNS topic."
  type        = string
}


# Lambdas

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

# variable "sns_topic_arn" {
#   description = "Arn of the sns topic"
#   type        = string
# }

# variable "lambda_api_role_name" {
#   description = "name of lmabda api role"
#   type        = string
# }

variable "resource_get_path" {
  type        = string
  description = "api path"
}

# variable "lambda_get_templates_invoke_arn" {
#   type        = any
#   description = "apigateway dependency"
# }
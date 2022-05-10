locals {
  display_name = coalesce(var.topic_display_name, var.topic_name)
}

# resource "aws_s3_bucket_policy" "delivery_status_bucket_policy" {
#   bucket = aws_s3_bucket.delivery_status_bucket.bucket
#   policy = data.aws_iam_policy_document.delivery_status_bucket_policy.json
# }

resource "aws_sns_sms_preferences" "sms_preferences" {
  default_sender_id                     = var.default_sender_id
  default_sms_type                      = var.default_sms_type
  monthly_spend_limit                   = var.monthly_spend_limit
  # usage_report_s3_bucket                = aws_s3_bucket.delivery_status_bucket.bucket
}

resource "aws_sns_topic" "topic" {
  display_name = local.display_name
  name         = var.topic_name
}

resource "aws_sns_topic_subscription" "subscription" {
  count     = length(var.subscriptions)
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = element(var.subscriptions, count.index)
}
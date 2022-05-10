output "lambda_post_inquiry_invoke_arn" {
  description = "the arn of lambda post inqury"

  value = aws_lambda_function.post_inquiry.invoke_arn
}

output "lambda_post_inquiry_arn" {
  description = "the arn of lambda post inqury"

  value = aws_lambda_function.post_inquiry.arn
}

output "lambda_get_templates_invoke_arn" {
  description = "the arn of lambda get templates"

  value = aws_lambda_function.get_templates.invoke_arn
}
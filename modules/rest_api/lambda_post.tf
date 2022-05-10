data "archive_file" "lambda_post_inquiry" {
  type = "zip"

  source_dir  = "${path.module}/src/functions_rest/post_inquiry"
  output_path = "${path.module}/src/functions_rest/post_inquiry.zip"
}

resource "aws_s3_object" "lambda_post_inquiry" {
  bucket = var.s3_lambda_rest_bucket_id

  key    = "rest_api/post_inquiry.zip"
  source = data.archive_file.lambda_post_inquiry.output_path


  etag = filemd5(data.archive_file.lambda_post_inquiry.output_path)
}
resource "aws_lambda_function" "post_inquiry" {
  function_name = var.lambda_post_inquiry_name
  role = "${aws_iam_role.lambda_post_inquiry_role.arn}"

  s3_bucket = var.s3_lambda_rest_bucket_id
  s3_key    = "rest_api/post_inquiry.zip"

  handler = "main.lambda_handler"
  runtime = "python3.8"

  source_code_hash = filebase64sha256("${path.module}/src/functions_rest/post_inquiry.zip")  # local path from where zip is uploaded to s3

  layers = [aws_lambda_layer_version.rest_responses_layer.arn]
   ephemeral_storage {
    size = 10240 # Min 512 MB and the Max 10240 MB
  }



  environment {
    variables = {
      SNS_TOPIC_ARN = var.sns_topic_arn
    }
  }
}

resource "aws_iam_role" "lambda_post_inquiry_role" {
  name = var.lambda_api_role_name

  assume_role_policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    })


}

resource "aws_iam_role_policy" "lambda_post_policy" {
  name = "lambda_cloudwatch_policy"
  role = aws_iam_role.lambda_post_inquiry_role.id

  policy = jsonencode(
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:*"
            ],
            "Resource": "*"
        },
  {
            "Effect": "Allow",
            "Action": [
                "sns:*"
            ],
            "Resource": "${var.sns_topic_arn}"
        }
    ]
})
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.post_inquiry.function_name}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${var.api_gateway_arn}/*/*"
}
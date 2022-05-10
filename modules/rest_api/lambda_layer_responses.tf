
data "archive_file" "lambda_layer_responses" {
  type = "zip"

  source_dir  = "${path.module}/src/layers/build"
  output_path = "${path.module}/src/layers/build.zip"
}

resource "aws_s3_object" "lambda-layer_responses" {
  bucket = var.s3_lambda_rest_bucket_id

  key    = "layers/lambda_layers.zip"
  source = data.archive_file.lambda_layer_responses.output_path

  # hashing, monitors when the layer changes
  etag = filemd5(data.archive_file.lambda_layer_responses.output_path)
  depends_on = [var.lambda_depends_on]
}

resource "aws_lambda_layer_version" "rest_responses_layer" {
  description = "http response layer for apis"
  s3_bucket   = var.s3_lambda_rest_bucket_id
  s3_key      = "layers/lambda_layers.zip"
  layer_name  = var.layer_name
  compatible_runtimes = var.compatible_runtimes
  source_code_hash = filebase64sha256("${path.module}/src/layers/build.zip") 
  depends_on = [aws_s3_object.lambda-layer_responses]
}
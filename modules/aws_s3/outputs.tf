# output "buckets" {
#   value = ["${aws_s3_bucket.s3_bucket.*.bucket}"]
# }

output "buckets_name_objects" {
  value = {
    for key, value in aws_s3_bucket.s3_bucket : key => value.bucket
  }
}

output "buckets_name_list" {
  value = [
    for value in aws_s3_bucket.s3_bucket : value.bucket
  ]
}

output "buckets_arn_objects" {
  value = {
    for key, value in aws_s3_bucket.s3_bucket : key => value.arn
  }
}

output "buckets_arn_list" {
  value = [
    for value in aws_s3_bucket.s3_bucket : value.arn
  ]
}
# output "buckets_arns" {
#   value = ["${aws_s3_bucket.s3_bucket.*.arn}"]
# }
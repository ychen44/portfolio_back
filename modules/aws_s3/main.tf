# locals {
#     bucket_count = "${length(var.s3_config)}"
# }

resource "aws_s3_bucket" "s3_bucket" {
    for_each = { for key, value in var.s3_config : key => value }

    bucket = each.value.bucket_name
    force_destroy =  each.value.force_destroy

    tags = var.tags
}
resource "aws_s3_bucket_acl" "bucket_acl" {

  for_each = aws_s3_bucket.s3_bucket

  bucket = each.value.id
  acl    = "private"
}

# resource "aws_s3_bucket" "s3_bucket" {
#     count = "${local.bucket_count}"
#     bucket = "${format("%s-%s", element(var.s3_config["bucket_names"], count.index), var.aws_region)}"
#     force_destroy = var.s3_config["force_destroy"]
#     # acl = "private"
#     # region = "${var.aws_region}"

#     tags= {
#         Name = "${format("%s-%s", element(var.s3_config["bucket_names"], count.index), var.aws_region)}"
#     }
# }


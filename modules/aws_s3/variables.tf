# variable "s3_config" {
#   type = map(list(string))

#   default = {
#     bucket_names = ["luxx-bucketa", "luxx-bucketb", "luxx-bucketc"]
#   }
# }

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

variable "aws_region" {
  type        = string
  description = "Region to deploy resources into."
}


   
variable "tags" {
  type        = map
  description = "Region to deploy resources into."
}

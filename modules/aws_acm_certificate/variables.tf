variable "tags" {
  type        = map
  description = "Region to deploy resources into."
}

variable "domain_name" {
  type        = string
  description = "domain name"
}

variable "subject_alternative_names" {
  type        = list
  description = "alternative domain names"
}



terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.8.0"
    }
  }
  backend "s3" {
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "portfolio-iac-tfstate-lock"

  }

}

provider "aws" {
  region = "us-east-1"

}
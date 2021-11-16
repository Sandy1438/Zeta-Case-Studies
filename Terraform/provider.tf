terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  # Make sure that the S3 bucket is created upfront
  // backend "s3" {
  //   bucket = "terraform-backend"
  //   key    = "statefile"
  //   region = "ap-south-1"
  //   access_key = ""
  //   secret_key = ""
  // }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.location
  access_key = ""
  secret_key = ""
}
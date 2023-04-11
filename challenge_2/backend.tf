# s3 backend for remote statefile storage
terraform {
  backend "s3" {
    bucket = "statestorebucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-bucket-24113"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "enable_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_table" {
  name         = "terraform_table_for_userID"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    bucket = "terraform-bucket-24113"
    key    = "esraa/terraform.tfstate"
    region = "us-east-2"
    profile = "admin_esraa"
    dynamodb_table = "terraform_table_for_userID"
    encrypt = true
  }
}

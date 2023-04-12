# S3 Bucket
resource "aws_s3_bucket" "statestorebucket123456789101" {
  bucket = "statestorebucket123456789101"
  acl    = "private"
  lifecycle_rule {
    id      = "remove_old_files"
    enabled = true

    prefix = "key_prefix/"

    expiration {
      days = 7
    }
  }
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

## To create dynamo db.
resource "aws_dynamodb_table" "state_lock" {
  name         = "state_lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
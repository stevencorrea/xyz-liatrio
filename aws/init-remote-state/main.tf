# This file provisions the infrastructure required for terraform to store it's state in a remote s3 backend.
# This is intended to be ran once to establish resources for storing terraform state.
# This is going to use 2 pipelines - one to test one to deploy
# To deploy this terraform, simply add or delete a comment

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_kms_key" "terraform_state_kms_key" {
  description             = "Encrypts xyz-terraform-state objects"
  deletion_window_in_days = 10
}
resource "aws_kms_alias" "terraform_state_kms_key_alias" {
  name          = "alias/terraform-state-key"
  target_key_id = aws_kms_key.terraform_state_kms_key.key_id
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "xyz-terraform-state-liatrio"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_acl" "terraform_state_acl" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_sse_rule" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform_state_kms_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "app-state"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
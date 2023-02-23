# Just a null resource to test terraform state

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket         = "xyz-terraform-state-liatrio"
    region         = "us-west-2"
    key            = "xyz-terraform-state-liatrio/terraform.tfstate"
    encrypt        = true
    kms_key_id     = "alias/terraform-state-key"
    dynamodb_table = "app-state"
  }
}

provider "aws" {
  region = "us-west-2"

  # Maybe we tag these resources by client to determin billbacks in a shared environment
  default_tags {
    tags = {
      Client       = "xyz"
      CostCategory = "Consulting"
      ProjectType  = "CloudMigration"
    }
  }
}

resource "null_resource" "test" {
}


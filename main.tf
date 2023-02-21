terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    region  = "us-west-1"
    key     = "xyz-liatrio/terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "us-west-1"
  default_tags {
    tags = {
      Client       = "xyz"
      CostCategory = "Consulting"
      ProjectType  = "CloudMigration"
    }
  }
}

resource "null_resource" "example" {
  triggers = {
    value = "A example resource that does nothing!"
  }
}
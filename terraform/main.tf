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

locals {
  cluster_name = "eks-${var.name}"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "${var.name}-vpc"

  cidr = "10.0.0.0/16"
  azs  = ["${var.region}a", "${var.region}b", "${var.region}c"]

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.100.0/24", "10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.10.0"

  cluster_name    = local.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    green = {
      name = "green-node-group"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }

    blue = {
      name = "blue-node-group"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.11.0"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project   = "root-account-alerts"
      ManagedBy = "Terraform"
    }
  }
}

provider "aws" {
  region = "us-east-1" # All IAM events like AWS ak/sk creation are usually logged in us-east-1 region
  default_tags {
    tags = {
      Project   = "root-account-alerts"
      ManagedBy = "Terraform"
    }
  }

  alias = "iam-events"
}

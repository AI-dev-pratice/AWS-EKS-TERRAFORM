terraform {
  required_version = ">= 1.1"  # use_lockfile requires 1.1+
  
  backend "s3" {
    bucket         = "terraform-aws-tf-state-bucket-733717814172"
    key            = "dev/eks/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"  # Optional: for state locking
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
    }
  }
}
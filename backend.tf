# resource "aws_s3_bucket" "terraform_state_bucket" {
#   bucket = "terraform-aws-tf-state-bucket-eks-1"

#   lifecycle {
#     prevent_destroy = true
#   }
#  }


# Project 1 — EKS infrastructure
terraform {
  backend "s3" {
    bucket         = "terraform-aws-tf-state-bucket-733717814172"
    key            = "dev/eks/terraform.tfstate"
    region         = "ap-south-1"
    use_lockfile   = true
    encrypt        = true
  }

required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 6.0.0"
  }
}
}
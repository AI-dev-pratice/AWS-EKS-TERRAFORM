provider "aws" {
  region = var.aws_region
}


resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-aws-tf-state-bucket-733717814172"

  lifecycle {
    prevent_destroy = false
  }
}

module "vpc" {
  source = "./module/vpc"

  region               = var.aws_region
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones   # List of availability zones to distribute subnets across
  public_subnets_cidr  = var.public_subnets_cidr  # CIDR blocks for public subnets
  private_subnets_cidr = var.private_subnets_cidr # CIDR blocks for private subnets
  eks_cluster_name     = var.eks_cluster_name     # Optional: used inside VPC module for tagging or naming
}


module "eks" {
  source = "./module/eks"

  region           = var.aws_region
  eks_cluster_name = var.eks_cluster_name          # Name of the EKS cluster to create
  cluster_version  = var.cluster_version           # Kubernetes version for the EKS control plane
  vpc_id           = module.vpc.vpc_id             # Use VPC ID output from the VPC module
  subnet_id        = module.vpc.private_subnet_ids # Use private subnet IDs from the VPC module
  node_groups      = var.node_groups               # Map of node group configurations to launch worker nodes
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "public_subnets_cidr" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "The availability zones for the subnets"
  type        = list(string)
}

variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

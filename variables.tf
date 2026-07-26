variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnets_cidr" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "eks_cluster_name" {
  description = "The name of my EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "My cluster version"
  type        = string

}

variable "node_groups" {
  description = "EKS node group configuration variable"

  type = map(
    object({
      instance_types = list(string)
      capacity_type  = string

      scaling_config = object({
        desired_size = number
        max_size     = number
        min_size     = number
      })
    })
  )
}


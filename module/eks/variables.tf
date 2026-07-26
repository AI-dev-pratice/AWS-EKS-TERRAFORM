variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"

}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

#subnet IDs for the EKS cluster
variable "subnet_id" {
  description = "Public Subnet IDs"
  type        = list(string)
}

#eks clluster name
variable "eks_cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.29"
}

variable "node_groups" {
  description = "Map of EKS node group configurations"
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    scaling_config = object({
      desired_size = number
      min_size     = number
      max_size     = number
    })
  }))
}

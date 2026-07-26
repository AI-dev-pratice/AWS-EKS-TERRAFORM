variable "region" {
  description = "AWS region"
  type = string
  default = "ap-south-1"

}

variable "vpc_id" {
  description = "VPC ID"
  type = string
}

#subnet IDs for the EKS cluster
variable "subnet_id" {
  description = "Public Subnet IDs"
  type = list(string)
}

#eks clluster name
variable "eks_cluster_name" {
  description = "EKS Cluster Name"
  type = string
}

#node group name
variable "node_group_name" {    
    
  description = "EKS Node Group Name"
  type = map(
    object({
      instance_type = string
      capacity_type = string

     scaling_config = object({
     desired_size = number  
      min_size = number
      max_size = number
    })
  )
}
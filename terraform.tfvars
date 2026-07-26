aws_region = "ap-south-1"

vpc_cidr = "10.0.0.0/16"

public_subnets_cidr = [
  "10.0.0.0/19",
  "10.0.32.0/19",
  "10.0.64.0/19",
]

private_subnets_cidr = [
  "10.0.96.0/19",
  "10.0.128.0/19",
  "10.0.160.0/19",
]

availability_zones = [
  "ap-south-1a",
  "ap-south-1b",
  "ap-south-1c",
]

eks_cluster_name = "amazon-dev-eks-cluster"
cluster_version  = "1.31"

node_groups = {
  dev = {
    instance_types = ["t2.micro"]
    capacity_type  = "ON_DEMAND"
    desired_size   = 2
    min_size       = 1
    max_size       = 3
  }
}
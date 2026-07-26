resource "aws_vpc" "eks-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Project = "EKS"
    Environment = "dev"
  }
}

resource "aws_subnet" "eks-public-subnet" {
  count                   = length(var.public_subnets_cidr)
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.eks_cluster_name}-public-subnet-${count.index + 1}"
    Project = "EKS"
    Environment = "dev"
  }
}

resource "aws_subnet" "eks-private-subnet" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.eks-vpc.id
  cidr_block        = element(var.private_subnets_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.eks_cluster_name}-private-subnet-${count.index + 1}"
    Project = "EKS"
    Environment = "dev"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.eks-vpc.id

  tags = {
    Name = "${var.eks_cluster_name}-igw"
    Project = "EKS"
    Environment = "dev"
  }
}

#elastic ip for nat gateway
resource "aws_eip" "eks-nat-eip" {
    vpc = true
    
    tags = {
        Name = "${var.eks_cluster_name}-nat-eip"
        Project = "EKS"
        Environment = "dev"
    }
    }

#NAT Gateway
resource "aws_nat_gateway" "eks-nat-gateway" {
 count = length(var.public_subnets_cidr)
 allocation_id = aws_eip.eks-nat-eip.id
  subnet_id     = element(aws_subnet.eks-public-subnet.*.id, count.index)

  tags = {
    Name = "${var.eks_cluster_name}-nat-gateway-${count.index + 1}"
    Project = "EKS"
    Environment = "dev"
  }

  #Route Table for Public Subnets
resource "aws_route_table" "eks-public-rt" {
  count = length(var.private_subnets_cidr)
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-igw.id 
  }
  tags = {
    Name = "${var.eks_cluster_name}-public-rt-${count.index + 1}"
    Project = "EKS"
    Environment = "dev"
  }
}

#private route table for private subnets
resource "aws_private_route_table" "eks-private-rt" {
  count = length(var.private_subnets_cidr)
  vpc_id = aws_vpc.eks-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks-nat-gateway.id
  }
    tags = {
        Name = "${var.eks_cluster_name}-private-rt-${count.index + 1}"
        Project = "EKS"
        Environment = "dev"
    }
}

#Route Table Association for Public Subnets
resource "aws_route_table_association" "eks-public-rt-assoc" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.eks-public-subnet.*.id, count.index)
  route_table_id = aws_route_table.eks-public-rt.id
}

#Route Table Association for Private Subnets
resource "aws_route_table_association" "eks-private-rt-assoc" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.eks-private-subnet.*.id, count.index)
  route_table_id = aws_private_route_table.eks-private-rt.id
}


# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = "my-vpc"
#   cidr = "10.0.0.0/16"

#   azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

#   enable_nat_gateway = true
#   enable_vpn_gateway = true

# }
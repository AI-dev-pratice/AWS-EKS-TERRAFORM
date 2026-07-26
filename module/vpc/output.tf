output "vpc_id"{
    value = aws_vpc.eks-vpc.id
}

#print the public subnet ids
output "public_subnet_ids" {    
    value = aws_subnet.eks-public-subnet[*].id
}   

#private subnet ids
output "private_subnet_ids" {               
    value = aws_subnet.eks-private-subnet[*].id
}
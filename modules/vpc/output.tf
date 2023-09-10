output "VPC_ID" {
  value = aws_vpc.vpc.id
}

output "PUB_SUB1_ID" {
  value = aws_subnet.pub_sub1.id
}
output "PUB_SUB2_ID" {
  value = aws_subnet.pub_sub2.id
}
output "PRI_SUB3_ID" {
  value = aws_subnet.pri_sub3.id
}

output "PRI_SUB4_ID" {
  value = aws_subnet.pri_sub4.id
}
output "IGW_ID" {
    value = aws_internet_gateway.igw
}

output "REGION" {
  value = var.REGION
}
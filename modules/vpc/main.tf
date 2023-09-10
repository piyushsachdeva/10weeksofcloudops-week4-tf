resource "aws_vpc" "vpc" {
  cidr_block       = var.VPC_CIDR
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_classiclink   = false
  enable_classiclink_dns_support = false
  assign_generated_ipv6_cidr_block = false



 # tags to assign to the resource.
  tags = {
    Name = "${var.PROJECT_NAME}-vpc"
  }
}

# create internet gateway and attach it to above vpc
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.PROJECT_NAME}-igw"
  }
}

# use data source to get avalablility zones in the region
data "aws_availability_zones" "availability_zones" {}

# create public subnet pub-sub1

resource "aws_subnet" "pub_sub1" {
  vpc_id                    = aws_vpc.vpc.id
  cidr_block                = var.PUB_SUB1_CIDR
  map_public_ip_on_launch   = true
  availability_zone         = data.aws_availability_zones.availability_zones.names[0]

    tags = {
    Name                        = "pub-sub1"
    "kubernetes.io/cluster/${var.PROJECT_NAME}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}

# create public subnet pub-sub2

resource "aws_subnet" "pub_sub2" {
  vpc_id                    = aws_vpc.vpc.id
  cidr_block                = var.PUB_SUB2_CIDR
  map_public_ip_on_launch   = true
  availability_zone         = data.aws_availability_zones.availability_zones.names[1]


  tags = {
    Name                        = "pub-sub2"
    "kubernetes.io/cluster/${var.PROJECT_NAME}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}

# create public route table

resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.PROJECT_NAME}-pub_rt"
  }
}

# associate public subnet pub-sub1 to "public route table"

resource "aws_route_table_association" "pub_rt_a" {
  subnet_id      = aws_subnet.pub_sub1.id
  route_table_id = aws_route_table.pub_rt.id
}

# associate public subnet pub-sub2 to "public route table"

resource "aws_route_table_association" "pub_rt_b" {
  subnet_id      = aws_subnet.pub_sub2.id
  route_table_id = aws_route_table.pub_rt.id
}

# create public subnet pri-sub3

resource "aws_subnet" "pri_sub3" {
  vpc_id             = aws_vpc.vpc.id
  cidr_block        = var.PRI_SUB3_CIDR
  availability_zone = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch = false
  
  tags = {
    Name                        = "pri-sub3"
    "kubernetes.io/cluster/${var.PROJECT_NAME}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

# create public subnet pri-sub4

resource "aws_subnet" "pri_sub4" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.PRI_SUB4_CIDR
  availability_zone = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name                        = "pri-sub4"
    "kubernetes.io/cluster/${var.PROJECT_NAME}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}
# create VPC
module "VPC" {
  source           = "../modules/vpc"
  REGION           = var.REGION
  PROJECT_NAME     = var.PROJECT_NAME
  VPC_CIDR         = var.VPC_CIDR
  PUB_SUB1_CIDR    = var.PUB_SUB1_CIDR
  PUB_SUB2_CIDR    = var.PUB_SUB2_CIDR
  PRI_SUB3_CIDR    = var.PRI_SUB3_CIDR
  PRI_SUB4_CIDR    = var.PRI_SUB4_CIDR
}

# create NAT GATEWAY
module "Nat-GW" {
  source           = "../modules/Nat-GW"
  IGW_ID           = module.VPC.IGW_ID
  VPC_ID           = module.VPC.VPC_ID
  PUB_SUB1_ID      = module.VPC.PUB_SUB1_ID
  PUB_SUB2_ID      = module.VPC.PUB_SUB2_ID
  PRI_SUB3_ID      = module.VPC.PRI_SUB3_ID
  PRI_SUB4_ID      = module.VPC.PRI_SUB4_ID
}

# create IAM
module "IAM" {
  source           = "../modules/IAM"
  PROJECT_NAME     = var.PROJECT_NAME
}

# create EKS Cluster
module "EKS" {
  source               = "../modules/EKS"
  PROJECT_NAME         = var.PROJECT_NAME
  EKS_CLUSTER_ROLE_ARN = module.IAM.EKS_CLUSTER_ROLE_ARN
  PUB_SUB1_ID        = module.VPC.PUB_SUB1_ID
  PUB_SUB2_ID        = module.VPC.PUB_SUB2_ID
  PRI_SUB3_ID        = module.VPC.PRI_SUB3_ID
  PRI_SUB4_ID        = module.VPC.PRI_SUB4_ID
}

# create Node Group
module "NodeGroup" {
  source               = "../modules/NodeGroup"
  NODE_GROUP_ARN  = module.IAM.NODE_GROUP_ROLE_ARN
  PRI_SUB3_ID          = module.VPC.PRI_SUB3_ID
  PRI_SUB4_ID          = module.VPC.PRI_SUB4_ID
  EKS_CLUSTER_NAME     = module.EKS.EKS_CLUSTER_NAME
}

#create EKS Cluster eks_cluster

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.PROJECT_NAME

  # The Amazon Resource Name (ARN) of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations

  role_arn = var.EKS_CLUSTER_ROLE_ARN
  # Desired Kubernetes master version
  version = "1.27"
  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true
    subnet_ids = [
        var.PUB_SUB1_ID,
        var.PUB_SUB2_ID,
        var.PRI_SUB3_ID,
        var.PRI_SUB4_ID
        ]
  }
}

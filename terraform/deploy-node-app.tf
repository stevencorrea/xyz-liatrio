provider "kubernetes" {
    host = data.aws_eks_cluster.cluster.endpoint
    
  
}
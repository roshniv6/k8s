terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.0"
  cluster_name    = "production-eks-cluster"
  cluster_version = "1.27"
  subnets         = ["subnet-12345678", "subnet-87654321"]
  vpc_id          = "vpc-12345678"
  node_groups = {
    eks_nodes = {
      desired_capacity = 3
      max_capacity     = 10
      min_capacity     = 2

      instance_type = "t3.medium"
      labels = {
        environment = "production"
        tier       = "backend"
      }
      taints = {
        dedicated {
        key       = "tier"
        value     = "backend"
        effect    = "NoSchedule"
      }
        }
}
      tags={
        Infrastructure = "eks"
        Project        = "production"

        }

    }

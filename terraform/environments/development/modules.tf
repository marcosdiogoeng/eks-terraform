module "vpc" {
  source       = "../../modules/vpc"
  vpc_cidr   = var.cidr_block
  tags         = local.tags
}

module "eks" {
  source           = "../../modules/eks"
  tags             = local.tags
  project_name     = var.project_name
  public_subnets = module.vpc.public_subnets
}

module "nodes" {
  source            = "../../modules/nodes"
  tags              = local.tags
  project_name      = var.project_name
  environment       = var.environment
  private_subnets = module.vpc.private_subnets
  cluster_name      = module.eks.cluster_name
}
module "vpc" {
  source       = "../../modules/vpc"
  cidr_block   = var.cidr_block
  tags         = local.tags
  project_name = var.project_name
}

module "eks" {
  source           = "../../modules/eks"
  tags             = local.tags
  project_name     = var.project_name
  subnet_public_1a = module.vpc.subnet_public_1a
  subnet_public_1b = module.vpc.subnet_public_1b
}

module "node_group" {
  source            = "../../modules/node-groups"
  tags              = local.tags
  project_name      = var.project_name
  environment       = var.environment
  subnet_private_1a = module.vpc.subnet_private_1a
  subnet_private_1b = module.vpc.subnet_private_1b
  cluster_name      = module.eks.cluster_name
}

module "load_balancer_controller" {
  source       = "../../modules/add-ons/load-balancer"
  tags         = local.tags
  project_name = var.project_name
  oidc         = module.eks.oidc
  cluster_name = module.eks.cluster_name
}
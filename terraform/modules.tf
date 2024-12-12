module "eks_network" {
  source       = "./modules/network"
  cidr_block   = var.cidr_block
  tags         = local.tags
  project_name = var.project_name
}

module "eks_cluster" {
  source           = "./modules/cluster"
  tags             = local.tags
  project_name     = var.project_name
  subnet_public_1a = module.eks_network.subnet_public_1a
  subnet_public_1b = module.eks_network.subnet_public_1b
}

module "eks_managed_node_group" {
  source            = "./modules/node-groups"
  tags              = local.tags
  project_name      = var.project_name
  environment       = var.environment
  subnet_private_1a = module.eks_network.subnet_private_1a
  subnet_private_1b = module.eks_network.subnet_private_1b
  cluster_name      = module.eks_cluster.cluster_name
}

module "eks_aws_load_balancer_controller" {
  source       = "./modules/load-balancer"
  tags         = local.tags
  project_name = var.project_name
  oidc         = module.eks_cluster.oidc
  cluster_name = module.eks_cluster.cluster_name
}
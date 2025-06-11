module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = var.cidr_block
  tags     = local.tags
}

module "eks" {
  source         = "../../modules/eks"
  tags           = local.tags
  project_name   = var.project_name
  public_subnets = module.vpc.public_subnets
}

module "nodes" {
  source          = "../../modules/nodes"
  tags            = local.tags
  project_name    = var.project_name
  environment     = var.environment
  private_subnets = module.vpc.private_subnets
  cluster_name    = module.eks.cluster_name
}

module "load_balancer" {
  source       = "../../modules/add-ons/load-balancer"
  vpc_id       = module.vpc.vpc_id
  tags         = local.tags
  project_name = var.project_name
  oidc         = module.eks.oidc
  cluster_name = module.eks.cluster_name
}

module "external_dns" {
  source       = "../../modules/add-ons/external-dns"
  tags         = local.tags
  project_name = var.project_name
  oidc         = module.eks.oidc
}

module "ebs_csi" {
  source       = "../../modules/add-ons/aws-ebs-csi"
  tags         = local.tags
  project_name = var.project_name
  oidc         = module.eks.oidc
}

module "external_secrets" {
  source       = "../../modules/add-ons/external-secrets"
  tags         = local.tags
  project_name = var.project_name
  oidc         = module.eks.oidc
}
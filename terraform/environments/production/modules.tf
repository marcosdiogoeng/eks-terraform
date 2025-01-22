module "vpc" {
  source       = "../../modules/vpc"
  cidr_block   = var.cidr_block
  tags         = local.tags
  project_name = var.project_name
}

module "rds" {
  source            = "../../modules/rds"
  tags              = local.tags
  subnet_private_1a = module.vpc.subnet_private_1a
  subnet_private_1b = module.vpc.subnet_private_1b
  vpc_id            = module.vpc.vpc
  cidr_block        = var.cidr_block
}

module "s3" {
  source = "../../modules/s3"
  tags   = local.tags
}

module "ec2" {
  source           = "../../modules/ec2"
  tags             = local.tags
  project_name     = var.project_name
  subnet_public_1a = module.vpc.subnet_public_1a
  vpc_id           = module.vpc.vpc

}

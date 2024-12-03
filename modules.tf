module "Networking" {
  source     = "./modules/network"
  cidr_block = var.cidr_block
  tags       = local.tags
}
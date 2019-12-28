module "vpc" {
  source = "../modules/vpc"
  common = var.common
}

module "ecr" {
  source = "../modules/ecr"
}

module "fargate" {
  source = "../modules/fargate"
  common = var.common
  vpc    = module.vpc.vpc
  ecr    = module.ecr.ecr
}

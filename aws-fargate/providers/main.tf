module "vpc" {
  source = "../modules/vpc"

  common = var.common
}

module "ecr" {
  source = "../modules/ecr"

  role = local.role
}

module "fargate" {
  source = "../modules/fargate"

  role   = local.role
  common = var.common
  vpc    = module.vpc.vpc
  ecr    = module.ecr.ecr
}

module "kinesis" {
  source = "../modules/kinesis-firehose"

  role = local.role
}

module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source = "./ec2"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  db-sg              = module.vpc.db_sg_id
  app-sg             = module.vpc.app_sg_id
}
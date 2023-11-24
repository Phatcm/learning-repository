terraform {
  required_version = ">= 1.0.0"
}

locals {
  name = var.project_name
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  profile = var.profile
}

module "dynamodb" {
  source = "./modules/dynamodb"
  tableName = var.tableName
  productId = var.productId
}

module "vpc" {
  source = "./modules/vpc"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  azs = var.azs
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}

module "rds" {
  source = "./modules/rds"
  engine = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  allocated_storage = var.allocated_storage
  username = var.username
  password = var.password
  database_sg_id = module.vpc.database_sg_id
  db_subnet_group_name = module.vpc.database_group_name
}
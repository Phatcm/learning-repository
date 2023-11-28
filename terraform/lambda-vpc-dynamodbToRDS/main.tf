terraform {
  required_version = ">= 1.0.0"
}

locals {
  name = var.project_name
}

# Configure the AWS Provider
provider "aws" {
  region  = var.region
  profile = var.profile
}

module "dynamodb" {
  source    = "./modules/dynamodb"
  tableName = var.tableName
  productId = var.productId
}

module "iam" {
  source = "./modules/iam"
  iamRoleName = var.iamRoleName
  policies_list = var.policies_list
}

module "vpc" {
  source           = "./modules/vpc"
  vpc_name         = var.vpc_name
  vpc_cidr         = var.vpc_cidr
  azs              = var.azs
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  database_subnets = var.database_subnets
  depends_on = [module.iam]
}

module "lambda" {
  source = "./modules/lambda"
  functionName = var.functionName
  lambdaHandler = var.lambdaHandler
  runtime = var.runtime
  private_subnets = module.vpc.private_subnets
  security_group_ids = module.vpc.security_group_ids
  iam_role_arn = module.iam.iam_role_arn

  #postgresql env
  db_host = module.rds.db_host
  db_name = module.rds.db_name
  db_username = module.rds.db_username
  db_password = module.rds.db_password
  db_port = module.rds.db_port
  
}

module "rds" {
  source               = "./modules/rds"
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  allocated_storage    = var.allocated_storage
  username             = var.username
  password             = var.password
  database_sg_id       = module.vpc.security_group_ids
  db_subnet_group_name = module.vpc.database_group_name
  parameter_group_name = module.vpc.database_pg_name
}


resource "aws_lambda_event_source_mapping" "dynamodb_stream_mapping" {
  event_source_arn  = module.dynamodb.dynamodb_stream_arn
  function_name     = module.lambda.lambda_function_arn
  enabled = true
  batch_size = 100
  starting_position = "LATEST"
}
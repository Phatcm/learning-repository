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

module "lambda"{
    source = "./modules/lambda"
    functionName = var.functionName
    lambdaRoleArn = var.lambdaRoleArn
    runtime = var.runtime
    lambda_handler = var.lambda_handler
}

module "alb"{
    source = "./modules/alb"
    lambdaRoleArn = var.lambdaRoleArn
    lambda_function = module.lambda.lambda_function
    lambda_arn = module.lambda.lambda_arn
}
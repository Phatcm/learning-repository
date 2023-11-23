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
/*
module "dynamodb"{
    source = "./modules/dynamodb"
    tableName = var.tableName
    productId = var.productId
}
*/
module "lambda"{
    source = "./modules/lambda"
    functionName = var.functionName
    lambdaRoleArn = var.lambdaRoleArn
    runtime = var.runtime
    lambda_handler = var.lambda_handler
}

module "apigateway"{
    source = "./modules/apigateway"
    apiName = var.apiName
    lambdaArn = module.lambda.lambda_arn
}

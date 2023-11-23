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

module "s3" {
  source = "./modules/s3"
  s3BucketName = var.s3BucketName
}

module "lambda" {
  source = "./modules/lambda"
  functionName = var.functionName
  lambdaRoleArn = module.iam_role.role_arn
  runtime = var.runtime
  lambdaHandler = var.lambdaHandler
  s3BucketName = module.s3.s3bucketName

}

module "iam_role" {
  source = "./modules/iam_role"
  iamRoleName = var.iamRoleName
  sqs_success_arn = module.sqs.success_queue_arn
  sqs_failure_arn = module.sqs.failure_queue_arn
}

module "sqs" {
  source = "./modules/sqs"
  lambda_arn = module.lambda.lambda_arn
}


#Permission for s3 notification to trigger lambda
resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_arn
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3.s3BucketArn
}


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = module.s3.s3bucketId

  lambda_function {
    lambda_function_arn = module.lambda.lambda_arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}

resource "aws_lambda_function_event_invoke_config" "lambda_destination" {
  function_name = module.lambda.lambda_function

  destination_config {
    on_success {
      destination = module.sqs.success_queue_arn
    }
    on_failure {
      destination = module.sqs.failure_queue_arn
    }
  }
}
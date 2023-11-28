#Lambda function
data "archive_file" "lambda" {
  type        = "zip"
  output_path = "lambda_function_payload.zip"
  source_dir  = "./resources/"
}

resource "aws_lambda_function" "lambda_function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = var.functionName
  role          = var.iam_role_arn

  handler         = var.lambdaHandler  # SET USING TFVARS
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime         = var.runtime

  vpc_config {
    subnet_ids = var.private_subnets
    security_group_ids = var.security_group_ids
  }

  timeout = 500

  environment {
    variables = {
      DB_NAME = var.db_name
      DB_USER = var.db_username
      DB_PASSWORD = var.db_password
      DB_HOST = var.db_host
      DB_PORT = var.db_port
    }
  }
}


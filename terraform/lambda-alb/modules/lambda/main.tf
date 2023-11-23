data "archive_file" "lambda" {
  type        = "zip"
  output_path = "lambda_function_payload.zip"
  source {
    content = file("./resources/lambda_function.py")
    filename = "lambda_function.py"
  }
}

resource "aws_lambda_function" "lambda_function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = var.functionName
  role          = var.lambdaRoleArn

  handler         = var.lambda_handler  # SET USING TFVARS
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime         = var.runtime
}

/*
resource "null_resource" "delete_zip" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "del /Q lambda_function_payload.zip"
  }
}
*/
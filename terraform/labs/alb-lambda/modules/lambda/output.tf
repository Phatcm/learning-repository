output "lambda_function"{
  value = aws_lambda_function.lambda_function.function_name
}

output "lambda_arn"{
  value = aws_lambda_function.lambda_function.arn
}
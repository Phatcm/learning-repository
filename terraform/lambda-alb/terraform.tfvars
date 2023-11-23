project_name = "lambda-alb"
region = "ap-southeast-1"
profile = "lambda"

#lambda_function
functionName ="lambda-alb"
lambdaRoleArn = "arn:aws:iam::728889845756:role/service-role/serverless-api-role"
runtime = "python3.9"
lambda_handler = "lambda_function.lambda_handler"
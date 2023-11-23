project_name = "serverless_api"
region = "ap-southeast-1"
profile = "lambda"

#dynamodb
tableName = "product_inventory"
productId = "productId"

#lambda_function
functionName ="serverless_api"
lambdaRoleArn = "arn:aws:iam::728889845756:role/service-role/serverless-api-role"
runtime = "python3.9"
lambda_handler = "lambda_function.lambda_handler"

#apigateway
apiName = "serverless_api"
project_name = "organize-s3-bucket"
region = "ap-southeast-1"
profile = "lambda"

#lambda_function
functionName ="organize-function"
runtime = "python3.9"
lambdaHandler = "lambda_function.lambda_handler"

#S3
s3BucketName = "organize-s3-bucket"

#iam_role
iamRoleName = "iam-role-lambda"
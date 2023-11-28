project_name = "organize-s3-bucket"
region       = "ap-southeast-1"
profile      = "lambda"

#dynamodb
tableName = "product-inventory"
productId = "itemId"

#vpc
vpc_name         = "my-vpc"
vpc_cidr         = "10.0.0.0/16"
azs              = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
public_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets  = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
database_subnets = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]

#rds
allocated_storage = 10
engine            = "postgres"
engine_version    = "12"
instance_class    = "db.t2.micro"
username          = "postgresql"
password          = "243278Gb"

#lambda
iamRoleName = "lambda-execute-role"
policies_list = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", 
    "arn:aws:iam::aws:policy/service-role/AWSLambdaDynamoDBExecutionRole",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
]

functionName = "read-dynamodb-lambda"
lambdaHandler = "lambda_function.lambda_handler"
runtime = "python3.9"
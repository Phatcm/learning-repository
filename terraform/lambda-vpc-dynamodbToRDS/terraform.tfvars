project_name = "organize-s3-bucket"
region = "ap-southeast-1"
profile = "lambda"

#dynamodb
tableName = "product-inventory"
productId = "itemId"

#vpc
vpc_name = "my-vpc"
vpc_cidr = "10.0.0.0/16"
azs = ["ap-southeast-1a","ap-southeast-1b"]
public_subnets = ["10.0.1.0/24","10.0.2.0/24"]
private_subnets = ["10.0.101.0/24","10.0.102.0/24"]

#rds
allocated_storage = 10
engine = "mysql"
engine_version = "5.7"
instance_class = "db.t2.micro"
username   = "admin"
password   = "243278Gb"
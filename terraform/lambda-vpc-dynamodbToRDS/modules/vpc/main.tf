module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  database_subnets = var.database_subnets

  create_database_subnet_group = true
}

/*
#internet gateway - vpc module already created
resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id
}

resource "aws_internet_gateway_attachment" "example" {
  internet_gateway_id = aws_internet_gateway.igw.id
  vpc_id              = module.vpc.vpc_id
}
*/

#vpc endpoint
resource "aws_vpc_endpoint" "vpc_dynamodb_endpoint" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.ap-southeast-1.dynamodb"
}

/*
#route table nat gateway then to dynamodb
resource "aws_route_table" "dynamodb-route-table" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.vpc.natgw_ids
  }
}

#route table association
resource "aws_vpc_endpoint_route_table_association" "route-table-connection" {
  route_table_id  = aws_route_table.dynamodb-route-table.id
  vpc_endpoint_id = aws_vpc_endpoint.vpc_dynamodb_endpoint.id
}
*/

#security group
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4"
  name = "database-sg"
  description = "database security group"
  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "database access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "database access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]
}

#subnet group with private subnets for database
resource "aws_db_parameter_group" "parameter_group"{
  name = "database-pg"
  family = "postgres12"
}

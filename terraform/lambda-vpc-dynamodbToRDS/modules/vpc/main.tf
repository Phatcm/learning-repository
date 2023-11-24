resource "aws_eip" "nat" {
  count = 2
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = true
  reuse_nat_ips       = true
  external_nat_ip_ids = "${aws_eip.nat.*.id}"
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

#webserver_sg
resource "aws_security_group" "webserver_sg" {
  name_prefix = "webserver_sg"
  description = "Security group for web server"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "http access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "https access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "webserver security group"
  }
}

# database_security_group
resource "aws_security_group" "database_sg" {
  name_prefix = "database_sg"
  description = "Security group for database"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags   = {
    Name = "database security group"
  }
}

#subnet group with private subnets for database
resource "aws_db_subnet_group" "database_group"{
  name       = "database_group"
  subnet_ids = module.vpc.private_subnets
}

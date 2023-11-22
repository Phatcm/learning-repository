resource "aws_dynamodb_table" "dynamodb_table" {
  name           = var.tableName
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = var.productId

  attribute {
    name = var.productId
    type = "S"
  }

  tags = {
    Name        = "${var.tableName}-table"
    Environment = "production"
  }
}
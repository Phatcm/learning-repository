resource "aws_dynamodb_table" "dynamodb_table" {
  name           = var.tableName
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = var.productId

  attribute {
    name = var.productId
    type = "S"
  }
  
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  tags = {
    Name        = "${var.tableName}-table"
    Environment = "production"
  }
}
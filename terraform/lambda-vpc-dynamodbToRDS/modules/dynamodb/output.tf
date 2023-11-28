output "dynamodb_stream_arn" {
  value = aws_dynamodb_table.dynamodb_table.stream_arn
}
output "success_queue_arn" {
  value = aws_sqs_queue.s3-sucess.arn
}
output "failure_queue_arn" {
  value = aws_sqs_queue.s3-failure.arn
}
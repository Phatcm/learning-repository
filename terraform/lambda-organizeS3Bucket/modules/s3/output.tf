output "s3bucketName" {
  value = aws_s3_bucket.s3-bucket.bucket
}

output "s3bucketId" {
  value = aws_s3_bucket.s3-bucket.id
}

output "s3BucketArn" {
  value = aws_s3_bucket.s3-bucket.arn
}
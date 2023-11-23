resource "aws_s3_bucket" "s3-bucket" {
  bucket = var.s3BucketName
  force_destroy = true #Fore delete even if there are files inside

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "s3-versioning" {
  bucket = aws_s3_bucket.s3-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
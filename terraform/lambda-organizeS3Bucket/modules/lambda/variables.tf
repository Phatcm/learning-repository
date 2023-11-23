variable "functionName" {
  type        = string
  description = "functionName"
}

variable "lambdaRoleArn" {
  type        = string
  description = "lambdaRoleArn"
}

variable "runtime" {
  type = string
  description = "runtime"
}

variable "lambdaHandler" {
  type = string
  description = "lambda_handler"
}

variable "s3BucketName" {
  type = string
  description = "s3BucketName"
}

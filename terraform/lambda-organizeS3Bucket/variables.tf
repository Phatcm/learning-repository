variable "project_name" {
  type = any
}

variable "region" {
  type = string
}

variable "profile" {
  type = string
}

#lambda
variable "functionName" {
  type = string
}

variable "runtime" {
  type = string
}

variable "lambdaHandler" {
  type = string
}

#S3
variable "s3BucketName" {
  type = string
}

#iam_role
variable "iamRoleName" {
  type = string
}
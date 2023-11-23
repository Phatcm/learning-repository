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

variable "lambda_handler" {
  type = string
  description = "lambda_handler"
}
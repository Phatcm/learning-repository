variable "project_name" {
  type = any
}

variable "region" {
  type = string
}

variable "profile" {
  type = string
}

#dynamodb
variable "tableName" {
  type        = string
  description = "tableName"
}

variable "productId" {
  type        = string
  description = "productId"
}

#lambda
variable "functionName" {
  type        = string
  description = "tableName"
}

variable "lambdaRoleArn" {
  type        = string
  description = "productId"
}

variable "runtime" {
  type        = string
  description = "runtime"
}

#apigateway
variable "apiName" {
  type        = string
  description = "apiName"
}
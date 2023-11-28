#lambda
variable "functionName" {
  type = string
}

variable "lambdaHandler" {
  type = string
}

variable "runtime" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "iam_role_arn" {
  type = string
}

#database environment input

#   DB_NAME = var.db_name
#   DB_USER = var.db_username
#   DB_PASSWORD = var.db_password
#   DB_HOST = var.db_host
#   DB_PORT = var.db_port

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "db_host" {
  type = string
}

variable "db_port" {
  type = string
}
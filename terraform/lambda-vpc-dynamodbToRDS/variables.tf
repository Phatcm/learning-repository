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
  type = string
}

variable "productId" {
  type = string
}

#vpc
variable "vpc_name" {
type = string
}

variable "vpc_cidr" {
type = string
}

variable "azs" {
type = list(string)
}

variable "public_subnets" {
type = list(string)
}
variable "private_subnets" {
type = list(string)
}

#rds
variable "allocated_storage" {
  type        = number
  description = "The amount of storage to allocate for the database (in GB)"
}

variable "engine" {
  type        = string
  description = "The storage type to use"
}

variable "engine_version" {
  type        = string
  description = "The storage type to use"
}

variable "instance_class" {
  type        = string
  description = "The storage type to use"
}

variable "username" {
  type        = string
  description = "The username to use for the database"
}

variable "password" {
  type        = string
  description = "The password to use for the database"
}
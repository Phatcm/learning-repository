variable "identifier" {
  type    = string
  default = "database"  
}

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

variable "database_sg_id" {
  type = list(string)
}


variable "db_subnet_group_name" {
  type = string
}

variable "parameter_group_name" {
  type = string
}

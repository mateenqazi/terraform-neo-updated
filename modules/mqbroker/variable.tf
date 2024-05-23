variable "environment" {
  type = string
}

variable "mq_security_group_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "broker_username" {
  type = string
}

variable "broker_password" {
  type = string
  sensitive = true
}

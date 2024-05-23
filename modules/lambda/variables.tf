variable "environment" {
  type = string
}

variable "managed_policy_arns" {
  type = list(string)
}

variable "lambda_zip_path" {
  type = string
}

variable "lambda_security_group_ids" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "mq_endpoint_ip" {
  type = string
}

variable "broker_username" {
  type = string
}

variable "broker_password" {
  type = string
}

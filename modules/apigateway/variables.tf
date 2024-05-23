variable "environment" {
  type = string
}

variable "api_gateway_security_group_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "log_group_arn" {
  type = string
}

variable "lambda_invoke_arn" {
  type = string
}

variable "lambda_function_name" {
  type = string
}

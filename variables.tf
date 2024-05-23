variable "region" {
  type = string
}

variable "ec2_instance_type" {
  description = "Type of Ec2 Instance"
  type = string
}

variable "ec2_instance_min_size" {
  description = "Minimum number of EC2 instances."
  type = number
}

variable "ec2_instance_max_size" {
  description = "Maximum number of EC2 instances."
  type = number
}

variable "postgres_username" {
  description = "Master database username."
  type        = string
  sensitive   = true
}

variable "postgres_password" {
  description = "Master database password."
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Name of the project."
  type = string
}

variable "postgres_instance" {
  description = "Name of the database instance."
  type = string
}

variable "environment" {
  description = "Environment for the deployment. Used for naming resources."
  type        = string
}

variable "mq_broker_username" {
  description = "MQ Broker username."
  type        = string
}

variable "mq_broker_password" {
  description = "MQ Broker password."
  type        = string
  sensitive   = true
}

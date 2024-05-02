variable "region" {
  type = string
}

variable "ec2-instance-type" {
  description = "Type of Ec2 Instance"
  type = string
}

variable "ec2-instance-min-size" {
  description = "Minimum number of EC2 instances."
  type = number
}

variable "ec2-instance-max-size" {
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

variable "progres_instance" {
  description = "Name of the database instance."
  type = string
}

variable "environment" {
  description = "Environment for the deployment. Used for naming resources."
  type        = string
}

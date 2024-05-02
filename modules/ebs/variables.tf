variable "ec2-instance-type" {
  description = "Instance Types"
  type        = string
}

variable "ec2-instance-min-size" {
  description = "Master database password, used by superhumans."
  type        = string
  sensitive   = true
}

variable "ec2-instance-max-size" {
  description = "Prefix to apply to resources created by this module. Must be unique."
  type        = string
  sensitive   = true
}

variable "subnets" {
  description = "Subnet IDs in which to host database resources."
  type = list(string)
}

variable "environment" {
  description = "Environment for the deployment. Used for naming resources."
  type        = string
}
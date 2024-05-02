variable "database_master_username" {
  description = "Master database username, used by superhumans."
  type        = string
  sensitive   = true
}

variable "database_master_password" {
  description = "Master database password, used by superhumans."
  type        = string
  sensitive   = true
}

variable "identifier_prefix" {
  description = "Prefix to apply to resources created by this module. Must be unique."
  type        = string
  sensitive   = true
}

variable "publicly_accessible" {
  description = "Publicly accessible database."
  type = bool
}

variable "subnets" {
  description = "Subnet IDs in which to host database resources."
  type = list(string)
}

variable "environment" {
  description = "Environment for the deployment. Used for naming resources."
  type        = string
}

variable "database-instance-count" {
  description = "Number of database instance count"
  type        = number
}
variable "region" {
  type = string
  default = "us-west-1"
}

variable "ec2-instance-type" {
  type = string
  default = "t2.micro"
}

variable "ec2-instance-minSize" {
  type = number
  default = 1
}

variable "ec2-instance-maxSize" {
  type = number
  default = 1
}

variable "mysql_username" {
 type = string
default = "neochargedev"
}

variable "mysql_password" {
 description = "RDS root user password"
   default = 12345678
}

variable "project_name" {
 type = string
  default = "neocharge"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}



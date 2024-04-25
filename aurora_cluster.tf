data "aws_availability_zones" "available" {}

# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "5.7.1"
#   name                 = var.project_name
#   cidr                 = "10.0.0.0/16"
#   azs                  = data.aws_availability_zones.available.names
#   public_subnets       = ["10.0.4.0/24", "10.0.5.0/24"]
#   enable_dns_hostnames = true
#   enable_dns_support   = true
# }

# resource "aws_db_subnet_group" "aurora" {
#   name       = "education-aurora"
#   subnet_ids = module.vpc.public_subnets
#   tags = {
#     Name = "Education Aurora"
#   }
#   depends_on = [module.vpc]
# }

# resource "aws_security_group" "aurora" {
#   name   = "education_aurora"
#   vpc_id = module.vpc.vpc_id
  
#   ingress {
#     from_port   = 3306  # MySQL port
#     to_port     = 3306  # MySQL port
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
  
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "education_aurora"
#   }
# }

# resource "aws_rds_cluster_parameter_group" "aurora" {
#   name   = "education-aurora-params"
#   family = "aurora-mysql5.7"
#   parameter {
#     name  = "log_queries_not_using_indexes"
#     value = "1"
#   }
# }

# resource "aws_rds_cluster" "cluster" {
#   engine                  = "aurora-mysql"
#   engine_mode             = "provisioned"
#   engine_version          = "5.7.mysql_aurora.2.07.10"
#   cluster_identifier      = var.project_name
#   master_username         = var.mysql_username
#   master_password         = var.mysql_password
  
#   # db_subnet_group_name    = aws_db_subnet_group.aurora.name
#   backup_retention_period = 7
#   skip_final_snapshot     = true
#   # vpc_security_group_ids  = [aws_security_group.aurora.id]
# }

# resource "aws_rds_cluster_instance" "cluster_instances" {
#   identifier         = "${var.project_name}-${count.index}"
#   count              = 1  # Adjust count as needed
#   cluster_identifier = aws_rds_cluster.cluster.id
#   instance_class     = "db.t3.medium"
#   engine             = aws_rds_cluster.cluster.engine
#   engine_version     = aws_rds_cluster.cluster.engine_version
  
#   publicly_accessible = true
# }

# output "private_subnet_ids" {
#   value = module.vpc.private_subnets
# }

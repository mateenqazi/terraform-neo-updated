data "aws_availability_zones" "available" {}

# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "5.7.1"
#   name                 = var.project_name
#   cidr                 = "10.0.0.0/16"
#   azs                  = data.aws_availability_zones.available.names
#   public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
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
#  ingress {
#     from_port   = 5432
#     to_port     = 5432
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 5432
#     to_port     = 5432
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "education_aurora"
#   }
# }

resource "aws_rds_cluster_parameter_group" "aurora" {
  name   = "aurora-cluster"
  family = "aurora-postgresql16"
  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_rds_cluster" "cluster" {
  engine                  = "aurora-postgresql"
  engine_mode             = "provisioned"
  engine_version          = "16.2"
  cluster_identifier      = var.project_name
  master_username         = var.postgres_username
  master_password         = var.postgres_password
  
  # db_subnet_group_name    = aws_db_subnet_group.aurora.name
  
  backup_retention_period = 7
  skip_final_snapshot     = true

# vpc_security_group_ids  = [aws_security_group.aurora.id] 

}

resource "aws_rds_cluster_instance" "cluster_instances" {
  identifier         = "${var.project_name}-${count.index}"
  count              = 2
  cluster_identifier = aws_rds_cluster.cluster.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.cluster.engine
  engine_version     = aws_rds_cluster.cluster.engine_version
  
  publicly_accessible = true
}

# output "private_subnet_ids" {
#   value = module.vpc.private_subnets
# }


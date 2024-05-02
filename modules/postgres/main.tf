resource "aws_rds_cluster_parameter_group" "aurora" {
  name   = "aurora-cluster-${lower(var.environment)}"
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
  cluster_identifier      = var.identifier_prefix
  master_username         = var.database_master_username
  master_password         = var.database_master_password
  
  # db_subnet_group_name    = aws_db_subnet_group.aurora.name
  
  backup_retention_period = 30
  skip_final_snapshot     = true

# vpc_security_group_ids  = [aws_security_group.aurora.id] 

}

resource "aws_rds_cluster_instance" "cluster_instances" {
  identifier         = "${var.identifier_prefix}-${count.index}"
  count              = var.database-instance-count
  cluster_identifier = aws_rds_cluster.cluster.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.cluster.engine
  engine_version     = aws_rds_cluster.cluster.engine_version
  publicly_accessible = var.publicly_accessible
}
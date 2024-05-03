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
  preferred_backup_window             = "07:40-08:10"
  preferred_maintenance_window        = "sun:08:20-sun:08:50"
  db_subnet_group_name    = var.db_subnet_group_name
  
  backup_retention_period = 30
  skip_final_snapshot     = true
storage_encrypted         = true
  vpc_security_group_ids  = var.vpc_security_group_ids

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
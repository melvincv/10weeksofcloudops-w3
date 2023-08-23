# Create a RDS DB subnet group
resource "aws_db_subnet_group" "cloudops-w3-subg" {
  name       = "cloudops-w3-subg"
  subnet_ids = [module.vpc.private_data_subnet_az1_id, module.vpc.private_data_subnet_az2_id]

  tags = {
    Name = "CloudOps W3 Aurora Subnet Group"
  }
}

# Create Aurora Cluster in the VPC
resource "aws_rds_cluster" "cloudops-w3-db" {
  cluster_identifier        = "cloudops-w3-db"
  engine                    = "aurora-mysql"
  engine_version            = "5.7.mysql_aurora.2.11.2"
  db_subnet_group_name      = aws_db_subnet_group.cloudops-w3-subg.id
  database_name             = "mywebappdb"
  master_username           = "melvincv"
  master_password           = "Lh6KgnYHnGV34defo4G2mJjvtnCuJB"
  backup_retention_period   = 5
  preferred_backup_window   = "02:00-03:00"
  skip_final_snapshot       = true
  final_snapshot_identifier = "cloudops-w3-db-final"
  vpc_security_group_ids    = [aws_security_group.cloudops-w3-db-sg.id]
  apply_immediately = true
}

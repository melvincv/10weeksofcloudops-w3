output "aurora_db_ep" {
  value = aws_rds_cluster.cloudops-w3-db.endpoint
}

output "aurora_db_cluster_id" {
  value = aws_rds_cluster.cloudops-w3-db.id
}

output "ec2_web1_publicip" {
  value = aws_instance.cloudops-w3-web1.public_ip
}

output "ec2_web2_publicip" {
  value = aws_instance.cloudops-w3-web2.public_ip
}
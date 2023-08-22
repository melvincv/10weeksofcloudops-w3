# Application Load Balancer
resource "aws_lb" "cloudops-w3-alb" {
  name               = "cloudops-w3-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [module.vpc.public_subnet_az1_id, module.vpc.public_subnet_az2_id]

  enable_deletion_protection = false

  tags = {
    Name    = "cloudops-w3"
    Project = "cloudops-w3"
  }
}

# Application Load Balancer Security Group
resource "aws_security_group" "cloudops-w3-alb-sg" {
  name        = "cloudops-w3-alb-sg"
  description = "Allow inbound HTTP and HTTPS traffic from All"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "cloudops-w3-alb-sg"
  }
}

# Web instances Security Group
resource "aws_security_group" "cloudops-w3-web-sg" {
  name        = "cloudops-w3-web-sg"
  description = "Allow inbound traffic from the App LB SG"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.cloudops-w3-alb-sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "cloudops-w3-web-sg"
  }
}

# Aurora Cluster Security Group
resource "aws_security_group" "cloudops-w3-db-sg" {
  name        = "cloudops-w3-db-sg"
  description = "Allow inbound MySQL traffic from the App SG"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "MySQL from Web EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.cloudops-w3-web-sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "cloudops-w3-db-sg"
  }
}

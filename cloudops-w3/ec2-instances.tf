# Data Source for Ubuntu Jammy AMI in ap-southeast-1 region
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "cloudops_w3_key" {
  key_name   = "cloudops_w3_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+uWLZPlXOw9IpWqsovuzUYvZVvWgGYZWygedrcAt8wCJ7pGxgZ1cds+2lwS5fogJZJZex/+fOBVN0u00rS14SNSqqB1HKmAJWPHqJ5Hi6VrTGNvy9QPzZ+xxVPFdxOyz0J7GRf/fWklWLMunOe5jsyiZS5p18z8D1bX3IITO8T++uGlGH7ltXODJCAztzLpNMfCqhXq951A9q4MZrzh9aoOPzlgz5h1lVUwQ6qmZmgFOXVtcdKbPxICs3xJdHK+Z7UM4dM+tpAeKwQoi+adspGKO0shqxSQ2Zc8wZJf5Y7rUSx5/2BUezgsJAYLB35Lnz4PDWTS27aRlHAGkY5g2aHDP6O2Dubjxf5D97+2jwzPQQqFrp7WF1jDJl3slB37938sOHxRbb6oPC+U9u27ZgCJ2CtqsMVdUo67Des4pzW1zUIx/shOlc2pCqjyVxYkEbvx6cM8QkwhhWiEAP8pw0xaV2QnQ3DyG8bLxxHQ11Jaki+TCl/19MC7lg/8waBDc= melro@MELZ-PC"
}

# EC2 instance in public_subnet_az1
resource "aws_instance" "cloudops-w3-web1" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = module.vpc.public_subnet_az1_id
  vpc_security_group_ids = ["aws_security_group.cloudops-w3-web-sg.id"]
  key_name               = aws_key_pair.cloudops_w3_key.key_name

  tags = {
    Name = "cloudops-w3-web-az1"
  }
}

# EC2 instance in public_subnet_az2
resource "aws_instance" "cloudops-w3-web2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = module.vpc.public_subnet_az2_id
  vpc_security_group_ids = ["aws_security_group.cloudops-w3-web-sg.id"]
  key_name               = aws_key_pair.cloudops_w3_key.key_name

  tags = {
    Name = "cloudops-w3-web-az2"
  }
}

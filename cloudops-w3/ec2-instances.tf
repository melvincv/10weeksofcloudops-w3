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

# EC2 instance in public_subnet_az1
resource "aws_instance" "cloudops-w3-web1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id = module.vpc.public_subnet_az1_id
  vpc_security_group_ids = ["aws_security_group.cloudops-w3-web-sg.id"]

  tags = {
    Name = "cloudops-w3-web-az1"
  }
}

# EC2 instance in public_subnet_az2
resource "aws_instance" "cloudops-w3-web2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id = module.vpc.public_subnet_az2_id
  vpc_security_group_ids = ["aws_security_group.cloudops-w3-web-sg.id"]

  tags = {
    Name = "cloudops-w3-web-az2"
  }
}

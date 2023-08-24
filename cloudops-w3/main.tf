terraform {
  required_version = ">= 1.4"
  backend "s3" {
    bucket         = "melvincv2023-terraform-state"
    key            = "cloudops-w3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "cloudops-w3-terraform-state-lock"
    # profile        = "terraform-user-desktop"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  # Configuration options
  region  = var.region
  # profile = "terraform-user-desktop"
}

# Call the local VPC module
module "vpc" {
  source                       = "../modules/vpc"
  region                       = var.region
  project_name                 = var.project_name
  vpc_cidr                     = var.vpc_cidr
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
}
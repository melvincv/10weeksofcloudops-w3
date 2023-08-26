variable "region" {
    type = string
    description = "AWS Region"
}
variable "project_name" {
    type = string
    description = "Name of the project"
}
variable "vpc_cidr" {
    type = string
    description = "CIDR value of the VPC"
}
variable "public_subnet_az1_cidr" {
    type = string
    description = "Public Web Subnet in AZ 1"
}
variable "public_subnet_az2_cidr" {
    type = string
    description = "Public Web Subnet in AZ 2"
}
variable "private_app_subnet_az1_cidr" {
    type = string
    description = "Private App Subnet in AZ 1"
}
variable "private_app_subnet_az2_cidr" {
    type = string
    description = "Private App Subnet in AZ 2"
}
variable "private_data_subnet_az1_cidr" {
    type = string
    description = "Private DB Subnet in AZ 1"
}
variable "private_data_subnet_az2_cidr" {
    type = string
    description =  "Private DB Subnet in AZ 2"
}
variable "MASTER_USER" {
  type = string
  description = "Aurora DB Master User"
}
variable "MASTER_PASS" {
  type = string
  description = "Aurora DB Master Password"
}
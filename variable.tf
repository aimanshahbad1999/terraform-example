variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "192.168.0.0/27"
}

variable "vpc_name" {
  type    = string
  default = "demo-vpc"
}

variable "public_subnet_cidr" {
  type    = string
  default = "192.168.0.0/28"
}

variable "public_subnet_name" {
  type    = string
  default = "Public Subnet"
}

variable "private_subnet_cidr" {
  type    = string
  default = "192.168.0.16/28"
}

variable "private_subnet_name" {
  type    = string
  default = "Private Subnet"
}

variable "IGW_Name" {
  type    = string
  default = "Demo Gateway"
}
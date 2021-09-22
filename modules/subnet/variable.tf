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



variable "vpc_id" {
 
}


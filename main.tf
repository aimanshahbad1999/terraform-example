
provider "aws" {
  region = var.region
}

resource "aws_vpc" "demo" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = var.public_subnet_name
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = var.private_subnet_name
  }
}

resource "aws_internet_gateway" "demo-gateway" {
  vpc_id = aws_vpc.demo.id
  tags = {
    Name = var.IGW_Name
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.demo.id

  route = [
    {
      cidr_block                = "0.0.0.0/0"
      egress_only_gateway_id    = ""
      gateway_id                = aws_internet_gateway.demo-gateway.id
      instance_id               = ""
      ipv6_cidr_block           = ""
      nat_gateway_id            = ""
      network_interface_id      = ""
      transit_gateway_id        = ""
      vpc_peering_connection_id = ""
      carrier_gateway_id = ""
      destination_prefix_list_id = ""
      ipv6_cidr_block = ""
      local_gateway_id = ""
      vpc_endpoint_id = ""
    }
  ]

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "rt_pub_sub" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "pub-sg" {
  name = "public sg"
   vpc_id      = aws_vpc.demo.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "public sg"
  }
}

resource "aws_key_pair" "ec2-pub" {
  key_name   = "key-for-ec2-terraform"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDC8lXx+LfYtJ/bdeO+tDMKNum6fZCJscDUE5HNfGGViE/atUP6XXOM8HEkwzHc7P6YNrY22syz+MWhqzVKWSxJ3wG2VypEtf0z1rsYb5QR78EPqmYx8Ns7ZkR+XBSd59H25w5bY0AQGOifHX/S4mkmUmT/eVRN9Wkm9HcTEVCycRbaUivW/DJqSv0MgcnxVFKPLHEaAvfIxwMmoppW6aN8cHXwmSitO2IL/f9B3IyIgIYbYLruVCD+ZevHK1mRbTdyBXATviIBTT0MoMxzZJ33faxVyGTqKAKb7LmosUhJae/BwXVGjNwRggvtO5vDKl4gfyikOhFMCdF7R/uVYnYP aiman.shahbad@AimanS-LP"
}


resource "aws_instance" "Ec2-pub" {
  ami           = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.pub-sg.id]
  associate_public_ip_address = true
  key_name=  aws_key_pair.ec2-pub.id
  tags = {
    Name = "EC2 public "
  }
}

resource "aws_instance" "Ec2-private" {
  ami           = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private-subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "EC2 private "
  }
}




resource "aws_subnet" "public-subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = var.public_subnet_name
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = var.private_subnet_name
  }
}
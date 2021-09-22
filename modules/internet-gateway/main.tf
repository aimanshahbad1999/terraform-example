
resource "aws_internet_gateway" "demo-gateway" {
  vpc_id =  var.vpc_id
  tags = {
    Name = var.IGW_Name
  }
}
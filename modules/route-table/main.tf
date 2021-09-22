

resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id

  route = [
    {
      cidr_block                = "0.0.0.0/0"
      egress_only_gateway_id    = ""
      gateway_id                = var.gateway_id
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
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.public_rt.id
}
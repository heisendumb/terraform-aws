resource "aws_vpc" "defaulttest_vpc" {
  cidr_block           = var.vpc_cidrblock
  enable_dns_support   = var.dns_support
  enable_dns_hostnames = var.dns_hostnames

  tags = {
    Name = "Default VPC to use in EC2."
  }
}

resource "aws_subnet" "defaulttest_subnet" {
  vpc_id                  = aws_vpc.defaulttest_vpc.id
  cidr_block              = var.subnet_cidrblock
  map_public_ip_on_launch = var.default_public_ip

  tags = {
    Name = "Default Subnet to use in EC2."
  }

}

resource "aws_network_acl" "default_vcpacl" {
  vpc_id     = aws_vpc.defaulttest_vpc.id
  subnet_ids = [aws_subnet.defaulttest_subnet.id]

  dynamic "ingress" {
    for_each = var.default_acl_ingress
    content {
      rule_no    = ingress.value["rule_no"]
      from_port  = ingress.key
      to_port    = ingress.value["target_port"]
      protocol   = ingress.value["protocol"]
      cidr_block = ingress.value["cidr_blocks"]
      action     = ingress.value["action"]
    }
  }

  dynamic "egress" {
    for_each = var.default_acl_egress
    content {
      rule_no    = egress.value["rule_no"]
      from_port  = egress.key
      to_port    = egress.value["target_port"]
      protocol   = egress.value["protocol"]
      cidr_block = egress.value["cidr_blocks"]
      action     = egress.value["action"]
    }
  }

  tags = {
    Name = "Default ACL to use in EC2."
  }
}

resource "aws_internet_gateway" "defaulttest_gw_vpc" {
  vpc_id = aws_vpc.defaulttest_vpc.id
  tags = {
    Name = "Default VPC internet GW"
  }
}

resource "aws_route_table" "defaulttest_route_table_vpc" {
  vpc_id = aws_vpc.defaulttest_vpc.id
  tags = {
    Name = "Default VPC route table"
  }
}

resource "aws_route" "defaultest_internet_acess_vpc" {
  route_table_id         = aws_route_table.defaulttest_route_table_vpc.id
  destination_cidr_block = var.destination_cidr
  gateway_id             = aws_internet_gateway.defaulttest_gw_vpc.id
}

resource "aws_route_table_association" "defaulttest_association_subnet_vpc" {
  subnet_id      = aws_subnet.defaulttest_subnet.id
  route_table_id = aws_route_table.defaulttest_route_table_vpc.id
}

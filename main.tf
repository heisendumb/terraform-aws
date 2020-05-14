module "vpc-heisenbuggerr" {
  source = "./modules/vpc"

  vpc_cidrblock       = var.vpc_cidrblock
  subnet_cidrblock    = var.subnet_cidrblock
  instance_tenancy    = var.instance_tenancy
  dns_support         = var.dns_support
  dns_hostnames       = var.dns_hostnames
  default_public_ip   = var.default_public_ip
  default_acl_ingress = var.default_acl_ingress
  default_acl_egress  = var.default_acl_egress
  destination_cidr    = var.destination_cidr

  providers = {
    aws = aws.dev
  }
}

module "sg-heisenbuggerr" {
  source = "./modules/sg"

  default_ingress = var.default_ingress

  providers = {
    aws = aws.dev
  }
}

module "ec2-heisenbuggerr" {
  source = "./modules/ec2"

  default_ingress = var.default_ingress

  providers = {
    aws = aws.dev
  }
}

terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "terraform-remote-state-storage-heisenbuggerr"
    dynamodb_table = "terraform-state-lock-dynamo"
    key            = "test/terraform_infra_state.tf"
    region         = "us-east-2"
    profile        = ""
  }
}

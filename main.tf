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
  vpc_default_id  = module.vpc-heisenbuggerr.vpc_default_id

  providers = {
    aws = aws.dev
  }
}

module "ec2-heisenbuggerr" {
  source        = "./modules/ec2"
  vpc_sg_ids    = module.sg-heisenbuggerr.security_group_id
  vpc_subnet_id = module.vpc-heisenbuggerr.vpc_subnet_id
  public_key    = var.public_key
  disk_size     = var.disk_size

  providers = {
    aws = aws.dev
  }
}

#module "eks-cluster" {
#  source           = "github.com/darkn3rd/eks-basic"
#  region           = var.region
#  eks_cluster_name = var.eks_cluster_name
#}

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

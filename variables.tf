variable "region_dev" {
  description = "AWS region to dev environment"
  default     = "us-east-2"
}

variable "region_prd" {
  description = "AWS region to prd environment"
  default     = "sa-east-1"
}

variable "awsprofile" {
  description = "AWS profile that containts access_key and secret_key"
  default     = ""
}

variable "instance_tenancy" {
  default = "default"
}

variable "dns_support" {
  description = "Enable DNS support in VPC"
  default     = true
}

variable "dns_hostnames" {
  description = "Enable DNS hostnames in VP"
  default     = true
}

variable "vpc_cidrblock" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidrblock" {
  description = "The CIDR block for the Subnet"
  default     = "10.0.1.0/24"
}

variable "default_public_ip" {
  description = "Launch instant with public ip"
  default     = true
}


variable "default_ingress" {
  description = "Inbound ports for Ingress"
  default = {
    22   = { description = "Inbound to SSH", cidr_blocks = ["127.0.0.1/32"] }
    80   = { description = "Inbound to HTTP", cidr_blocks = ["127.0.0.1/32"] }
    443  = { description = "Inbound to HTTPS", cidr_blocks = ["127.0.0.1/32"] }
    5432 = { description = "Inbound to PostgreSQL", cidr_blocks = ["127.0.0.1/32"] }
  }
}

variable "default_acl_ingress" {
  description = "ACL at VPN for ingress ports"
  default = {
    22   = { description = "Inbound to SSH", cidr_blocks = "0.0.0.0/0", target_port = 22, protocol = "tcp", rule_no = 100, action = "allow" }
    80   = { description = "Inbound to HTTP", cidr_blocks = "0.0.0.0/0", target_port = 80, protocol = "tcp", rule_no = 200, action = "allow" }
    443  = { description = "Inbound to HTTPS", cidr_blocks = "0.0.0.0/0", target_port = 443, protocol = "tcp", rule_no = 300, action = "allow" }
    5432 = { description = "Inbound to PostgreSQL", cidr_blocks = "0.0.0.0/0", target_port = 5432, protocol = "tcp", rule_no = 400, action = "allow" }
    1024 = { description = "Inbound to Ephemeral ports", cidr_blocks = "0.0.0.0/0", target_port = 65535, protocol = "tcp", rule_no = 500, action = "allow" }
  }
}

variable "default_acl_egress" {
  description = "ACL at VPN for egress ports"
  default = {
    22   = { description = "Outbound to SSH", cidr_blocks = "0.0.0.0/0", target_port = 22, protocol = "tcp", rule_no = 100, action = "allow" }
    1024 = { description = "Outbound to Ephemeral ports", cidr_blocks = "0.0.0.0/0", target_port = 65535, protocol = "tcp", rule_no = 500, action = "allow" }
  }
}

variable "destination_cidr" {
  description = "Default cidr block destination"
  default     = "0.0.0.0/0"
}

variable "public_key" {
  description = "Public key"
  default     = "/home/heisenbuggerr/.ssh/heisenbuggerr.pub"
}

variable "disk_size" {
  description = "EBS size"
  default     = 10
}

variable eks_cluster_name {
  description = "k8s AWS cluster name"
  default     = "adorable-unicorn"
}

variable "instance_tenancy" {
  type = string
}

variable "dns_support" {
  description = "Enable DNS support in VPC"
  type        = string
}

variable "dns_hostnames" {
  description = "Enable DNS hostnames in VP"
  type        = bool
}

variable "vpc_cidrblock" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_cidrblock" {
  description = "The CIDR block for the Subnet"
  type        = string
}

variable "default_public_ip" {
  description = "Launch instant with public ip"
  type        = bool
}

variable "default_acl_ingress" {
  description = "Inbound ports for Ingress"
  type        = map(object({ description = string, cidr_blocks = string, target_port = number, protocol = string, rule_no = number, action = string }))
}

variable "default_acl_egress" {
  description = "Inbound ports for Egress"
  type        = map(object({ description = string, cidr_blocks = string, target_port = number, protocol = string, rule_no = number, action = string }))
}

variable "destination_cidr" {
  description = "Default cidr block destination"
  default     = "0.0.0.0/0"
}

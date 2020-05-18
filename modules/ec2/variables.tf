variable "vpc_sg_ids" {
  description = "VPC security group ID"
  type        = string
}

variable "vpc_subnet_id" {
  description = "VPC security group ID"
  type        = string
}

variable "public_key" {}

variable "disk_size" {
  description = "EBS size"
  type        = number
}

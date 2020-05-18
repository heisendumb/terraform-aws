variable "default_ingress" {
  description = "Inbound ports for Ingress"
  type        = map(object({ description = string, cidr_blocks = list(string) }))
}

variable "vpc_default_id" {
  description = "VPC id"
  type        = string
}

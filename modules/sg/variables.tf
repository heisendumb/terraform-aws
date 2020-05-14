variable "default_ingress" {
  description = "Inbound ports for Ingress"
  type        = map(object({ description = string, cidr_blocks = list(string) }))
}

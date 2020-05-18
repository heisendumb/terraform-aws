variable eks_cluster_name {
  description = "k8s AWS cluster name"
  type        = string
}

variable "instance_type" {
  default = "m5.large"
}
variable "workers_additional_policies" {
  default = []
}

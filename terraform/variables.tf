variable "name" {
  description = "Project Name"
  type        = string
  default     = "xyz-liatrio"
}

variable "cluster_version" {
  description = "Version of k8s for EKS"
  type        = string
  default     = "1.24"

}

variable "azs" {
  description = "Availability Zones to deploy nodes into"
  type        = list(any)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}
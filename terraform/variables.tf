variable "name" {
  description = "Project Name"
  type        = string
  default     = "xyz-liatrio"
}

variable "terraform_state_bucket_name" {
  description = "Bucket name from init-remote-state output"
  type        = string
  default     = "xyz-terraform-state-liatrio"
}

variable "cluster_version" {
  description = "Version of k8s for EKS"
  type        = string
  default     = "1.24"

}

variable "azs" {
  description = "Availability Zones to deploy nodes into"
  type        = list(any)
  default     = ["us-west-1a", "us-west-1b", "us-west-1c"]
}
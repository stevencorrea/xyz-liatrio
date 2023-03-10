variable "name" {
  description = "Project Name"
  type        = string
  default     = "xyz-liatrio"
}

variable "region" {
  description = "Region for deploy"
  type        = string
  default     = "us-west-2"

}

variable "cluster_version" {
  description = "Version of k8s for EKS"
  type        = string
  default     = "1.24"
}
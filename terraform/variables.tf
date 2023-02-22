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

variable "access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}
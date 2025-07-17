# variables.tf (in the root directory)

variable "gcp_project_id" {
  type        = string
  description = "The GCP project ID to deploy resources into."
  default = "regal-spark-464611-v3"
}

variable "gcp_region" {
  type        = string
  description = "The GCP region for the resources."
  default     = "us-east1"
}

variable "gcp_zone" {
  type        = string
  description = "The GCP zone for the VM instance."
  default     = "us-east1-b"
}
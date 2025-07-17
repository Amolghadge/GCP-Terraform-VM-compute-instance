# modules/gcp-vm/variables.tf

variable "instance_name" {
  description = "Name of the compute instance."
  type        = string
}

variable "machine_type" {
  description = "Machine type for the instance."
  type        = string
  default     = "e2-medium"
}

variable "zone" {
  description = "The zone to create the instance in."
  type        = string
}

# We are replacing 'boot_disk_image' with these two variables
variable "image_family" {
  description = "The image family to use for the boot disk (e.g., 'ubuntu-2004-lts')."
  type        = string
  default     = "debian-11" # A safe default
}

variable "image_project" {
  description = "The project where the image family is located (e.g., 'ubuntu-os-cloud')."
  type        = string
  default     = "debian-cloud" # A safe default
}

variable "subnetwork" {
  description = "The subnetwork to attach the instance to."
  type        = string
  default     = "default"
}

variable "tags" {
  description = "A list of network tags to apply to the instance."
  type        = list(string)
  default     = []
}
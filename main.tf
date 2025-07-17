# main.tf (in the root directory)

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# Call the local module to create a web server VM
module "web_server_vm" {
  source = "./modules/gcp-vm" // Path to the module

  # Pass values to the module's variables
  instance_name = "web-server-from-module"
  machine_type  = "e2-small"
  zone          = var.gcp_zone
  tags          = ["web-server", "production"]
}

# You can reuse the module to create another VM easily!
module "db_server_vm" {
  source = "./modules/gcp-vm"

  instance_name = "db-server-from-module"
  machine_type  = "e2-medium"
  zone          = var.gcp_zone
  tags          = ["database", "production"]

  # Update this line to the newer LTS version
  image_family  = "ubuntu-2204-lts" # <--- UPDATED VALUE
  image_project = "ubuntu-os-cloud"
}
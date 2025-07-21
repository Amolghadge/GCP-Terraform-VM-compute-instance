# modules/gcp-vm/main.tf

# Data source to get the latest boot image from a family.
# This happens during the 'plan' stage.
# data "google_compute_image" "vm_image" {
#   family  = var.image_family
#   project = var.image_project
# }

resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = var.subnetwork
    access_config {} // For an ephemeral public IP
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

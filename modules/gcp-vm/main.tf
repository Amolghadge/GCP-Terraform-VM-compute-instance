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

resource "google_storage_bucket" "terraform_state" {
  name          = "my-terraform-state-bucket"   # must be globally unique
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365
    }
  }
}

resource "google_storage_bucket_iam_member" "terraform_sa_admin" {
  bucket = google_storage_bucket.terraform_state.name
  role   = "roles/storage.admin"
  member = "serviceAccount:gcpowner@regal-spark-464611-v3.iam.gserviceaccount.com"
}



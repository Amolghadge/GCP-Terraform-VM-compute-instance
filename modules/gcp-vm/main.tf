# modules/gcp-vm/main.tf

# Data source to get the latest boot image from a family.
# This happens during the 'plan' stage.
# data "google_compute_image" "vm_image" {
#   family  = var.image_family
#   project = var.image_project
# }

terraform {
  backend "gcs" {
    bucket = "my-terraform-state-bucket"
    prefix = "terraform/state"
  }
}

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
  name                        = "my-terraform-state-bucket" # must be globally unique
  location                    = "us-central1"
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}

# IAM for Service Account
resource "google_storage_bucket_iam_member" "tf_state_object_admin" {
  bucket = google_storage_bucket.terraform_state.name
  role   = ["roles/storage.objectAdmin", "roles/storage.objects.list"]
  member = "serviceAccount:gcpowner@regal-spark-464611-v3.iam.gserviceaccount.com"
}

resource "google_storage_bucket_iam_member" "tf_state_bucket_reader" {
  bucket = google_storage_bucket.terraform_state.name
  role   = "roles/storage.legacyBucketReader"
  member = "serviceAccount:gcpowner@regal-spark-464611-v3.iam.gserviceaccount.com"
}




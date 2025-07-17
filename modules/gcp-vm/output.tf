# modules/gcp-vm/outputs.tf

output "id" {
  description = "The unique ID of the instance."
  value       = google_compute_instance.this.id
}

output "name" {
  description = "The name of the instance."
  value       = google_compute_instance.this.name
}

output "external_ip" {
  description = "The external IP address of the instance."
  value       = google_compute_instance.this.network_interface[0].access_config[0].nat_ip
}

output "internal_ip" {
  description = "The internal IP address of the instance."
  value       = google_compute_instance.this.network_interface[0].network_ip
}
# modules/gcp-vm/outputs.tf

output "id" {
  description = "The unique ID of the instance."
  value       = google_compute_instance.vm_instance.id
}

output "name" {
  description = "The name of the instance."
  value       = google_compute_instance.vm_instance.name
}

output "external_ip" {
  description = "The external IP address of the instance."
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "internal_ip" {
  description = "The internal IP address of the instance."
  value       = google_compute_instance.vm_instance.network_interface[0].network_ip
}

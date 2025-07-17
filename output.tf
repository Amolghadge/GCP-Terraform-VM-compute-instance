# outputs.tf (in the root directory)

output "web_server_external_ip" {
  description = "External IP of the web server."
  # Access an output from the module like this: module.<module_name>.<output_name>
  value = module.web_server_vm.external_ip
}

output "database_server_internal_ip" {
  description = "Internal IP of the database server."
  value       = module.db_server_vm.internal_ip
}
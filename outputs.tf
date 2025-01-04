output "ip_output_list" {
  value = local.app_service.possible_outbound_ip_address_list
}

output "webapp_name" {
  value = local.app_service.name
}
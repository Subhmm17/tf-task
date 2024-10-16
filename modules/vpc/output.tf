output "vpc_id" {
  description = "VPC ID"
  value       = google_compute_network.vpc_network.id
}

output "subnet_id" {
  description = "Created Subnet ID"
  value       = google_compute_subnetwork.subnet.id
}

output "firewall_name" {
  description = "The name of the firewall rule created."
  value       = google_compute_firewall.allow-http-https.name 
}

output "vpc_self_link" {
  description = "The self-link of VPC network"
  value       = google_compute_network.vpc_network.self_link
}
output "vpc_name" {
  description = "The name of the VPC network."
  value       = google_compute_network.vpc_network.name
}
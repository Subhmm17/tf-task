output "vpc_peering_1_to_2_name" {
  value = google_compute_network_peering.vpc_peering_1_to_2.name
}

output "vpc_peering_2_to_1_name" {
  value = google_compute_network_peering.vpc_peering_2_to_1.name
}

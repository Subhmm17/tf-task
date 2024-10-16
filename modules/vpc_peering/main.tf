# VPC Peering from 1 to 2
resource "google_compute_network_peering" "vpc_peering_1_to_2" {
  name         = "${var.vpc_1_name}-to-${var.vpc_2_name}-peering"
  network      = var.vpc_1_self_link
  peer_network = var.vpc_2_self_link
}

# VPC Peering from 2 to 1
resource "google_compute_network_peering" "vpc_peering_2_to_1" {
  name         = "${var.vpc_2_name}-to-${var.vpc_1_name}-peering"
  network      = var.vpc_2_self_link
  peer_network = var.vpc_1_self_link
}

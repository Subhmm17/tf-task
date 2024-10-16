resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_ip_range
  region        = var.region
  network       = google_compute_network.vpc_network.name
}

resource "google_compute_firewall" "allow-http-https" {
  name    = "${var.vpc_name}-allow-http-https"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = var.allow_ports
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_subnetwork" "reserved_subnet" {
  name          = "${var.vpc_name}-reserved"
  ip_cidr_range = var.reserved_subnet_ip_range
  region        = var.region
  network       = google_compute_network.vpc_network.name
  purpose       = "INTERNAL"  # Specify the purpose for the subnet
}
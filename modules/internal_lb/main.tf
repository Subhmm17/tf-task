resource "google_compute_region_backend_service" "internal_backend" {
  name                  = "internal-backend-${var.vpc_name}"
  load_balancing_scheme = "INTERNAL"

  backend {
    group = var.instance_group_name
    balancing_mode = "CONNECTION"
  }

  health_checks = [google_compute_health_check.internal_health_check.self_link]
}

resource "google_compute_health_check" "internal_health_check" {
  name               = "internal-health-check-${var.vpc_name}"
  check_interval_sec = 10
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2

  tcp_health_check {
    port = "80"
  }
}

resource "google_compute_forwarding_rule" "ilb_forwarding_rule" {
  name            = "internal-lb-${var.vpc_name}"
  backend_service = google_compute_region_backend_service.internal_backend.self_link
  ip_address      = google_compute_address.internal_lb_ip.address
  port_range      = "80"
}

resource "google_compute_address" "internal_lb_ip" {
  name   = "ilb-ip-${var.vpc_name}"
  region = var.region
}

resource "google_compute_subnetwork" "reserved_subnet" {
  name          = "${var.vpc_name}-reserved-subnet"
  ip_cidr_range = var.reserved_subnet_ip_range
  region        = var.region
  network       = var.vpc_name
  purpose = "GLOBAL_MANAGED_PROXY"
}

resource "google_compute_global_address" "http_lb_ip" {
  name = "http-lb-ip"
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "http-lb-proxy"
  url_map = google_compute_url_map.http_map.self_link
}

resource "google_compute_url_map" "http_map" {
  name = "http-lb-map"

  default_service = google_compute_backend_service.http_backend.self_link
}

resource "google_compute_backend_service" "http_backend" {
  name                  = "http-backend"
  load_balancing_scheme = "EXTERNAL"

  backend {
    group          = var.mig1_self_link  # Link to the first instance group
    balancing_mode  = "UTILIZATION"
  }

  backend {
    group          = var.mig2_self_link  # Link to the second instance group
    balancing_mode  = "UTILIZATION"
  }

  health_checks = [google_compute_health_check.http_health_check.self_link]
}

resource "google_compute_health_check" "http_health_check" {
  name               = "http-health-check"
  check_interval_sec = 10
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2

  http_health_check {
    port         = "80"
    request_path = "/"
  }
}

resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name        = "http-lb-rule"
  ip_address  = google_compute_global_address.http_lb_ip.address
  target      = google_compute_target_http_proxy.http_proxy.self_link
  port_range  = "80"
}

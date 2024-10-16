output "lb_ip_address" {
  description = "The IP of the HTTP lb."
  value       = google_compute_global_forwarding_rule.http_forwarding_rule.ip_address
}

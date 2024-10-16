output "lb_ip_address" {
  description = "The IP of the internal load balancer."
  value       = google_compute_forwarding_rule.ilb_forwarding_rule.ip_address
}

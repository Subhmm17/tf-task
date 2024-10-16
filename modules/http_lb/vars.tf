variable "region" {
  description = "The region for the load balancer."
  type        = string
}

variable "mig1_self_link" {
  description = "Self-link of Managed Instance Group 1."
  type        = string
}

variable "mig2_self_link" {
  description = "Self-link of Managed Instance Group 2."
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC for the internal load balancer."
  type        = string
}

variable "region" {
  description = "The region for the internal load balancer."
  type        = string
}

variable "instance_group_name" {
  description = "The self-link of the instance group to attach to the internal load balancer."
  type        = string
}

variable "reserved_subnet_ip_range" {
  description = "CIDR range for the reserved subnet."
  type        = string
}

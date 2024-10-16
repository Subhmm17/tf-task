variable "vpc_name" {
  description = "name of VPC"
  type        = string
}

variable "subnet_name" {
  description = "name of subnet."
  type        = string
}

variable "subnet_ip_range" {
  description = "CIDR range of subnet."
  type        = string
}

variable "reserved_subnet_ip_range" {
  description = "CIDR range for the reserved subnet."
  type        = string
}

variable "allow_ports" {
  description = "Ports to allow in firewall rules."
  type        = list(string)
}

variable "region" {
  description = "region for VPC and subnets."
  type        = string
}

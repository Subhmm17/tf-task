variable "instance_group_name" {
  description = "name of instance group."
  type        = string
}

variable "zone" {
  description = "zone for instance group."
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC in which the MIG will be created"
  type        = string
}

variable "region" {
  description = "Region where the resources will be created"
  type        = string
}
variable "subnet_name" {
  description = "Name of the subnet where the instance template will be created"
  type        = string
}
output "instance_group" {
  description = "name of MIG"
  value       = google_compute_instance_group_manager.mig.name
}

output "instance_template_name" {
  description = "name of instance template used for MIG."
  value       = google_compute_instance_template.instance_template.name
}

output "instance_template_self_link" {
  description = "self-link of the instance template used for MIG."
  value       = google_compute_instance_template.instance_template.self_link
}

output "instance_group_self_link" {
  description = "self-link of the MIG"
  value       = google_compute_instance_group_manager.mig.instance_group
}


output "instance_group_name" {
  description = "name of MIG"
  value       = google_compute_instance_group_manager.mig.name
}
resource "google_compute_instance_template" "instance_template" {
  name         = "${var.instance_group_name}-template"
  machine_type = "n1-standard-1"
  region       = var.region

  disk { 
    auto_delete = true
    boot        = true
    source_image = "debian-cloud/debian-11"
  }

  network_interface {
    network    = var.vpc_name  
    subnetwork = var.subnet_name
    access_config {}
  }
  metadata = {
    startup-script = <<-EOT
      #!/bin/bash
      apt-get update
      apt-get install -y apache2
      systemctl start apache2
      systemctl enable apache2
      echo "<h1>Welcome to Apache on GCP! 01</h1>" > /var/www/html/index.html
    EOT
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_manager" "mig" {
  name                = var.instance_group_name
  zone                = var.zone
  base_instance_name  = "${var.instance_group_name}-instance"
  version {
    instance_template = google_compute_instance_template.instance_template.self_link
  }
  target_size         = 1
}

resource "google_compute_health_check" "http_health_check" {
  name               = "${var.instance_group_name}-health-check"
  check_interval_sec = 10
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2

  http_health_check {
    port         = 80                    # Change this if your service uses a different port
    request_path = "/"                    # Adjust based on your application's health check endpoint
  }
}

provider "google" {
  project = "terraform-ci-cd-project-443523"
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_compute_instance" "default" {
  name         = "ci-cd-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = " c0-deeplearning-common-cpu-v20230925-debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

 metadata_startup_script = <<-EOF
  #!/bin/bash
  sudo apt-get update
  sudo apt-get install -y nginx
  curl -o /var/www/html/index.html https://raw.githubusercontent.com/Amanjit22/gcloud/main/index.html
  sudo systemctl start nginx
EOF

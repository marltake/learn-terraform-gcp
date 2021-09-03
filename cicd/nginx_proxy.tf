resource "google_compute_network" "vpc_network" {
  name = "cicd-network"
}
resource "google_compute_instance" "nginx_instance" {
  name         = "reverse-proxy"
  machine_type = "e2-micro"
  tags         = ["web", "dev"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = 30
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
resource "google_compute_firewall" "develop" {
  name    = "ssh-firewall"
  network = google_compute_network.vpc_network.name

  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags   = ["dev"]
  source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "frontend" {
  name    = "http-firewall"
  network = google_compute_network.vpc_network.name

  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  target_tags   = ["web"]
  source_ranges = ["0.0.0.0/0"]
}

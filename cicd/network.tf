resource "google_compute_network" "vpc_network" {
  name = "cicd-network"
}
resource "google_compute_firewall" "vpc-allow-internal" {
  name    = "vpc-allow-internal"
  network = google_compute_network.vpc_network.name

  direction = "INGRESS"
  allow { protocol = "tcp" }
  allow { protocol = "udp" }
  allow { protocol = "icmp" }
  source_ranges = ["10.128.0.0/9"]
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

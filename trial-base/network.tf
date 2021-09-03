resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "vpc_subnet" {
  name                     = "vpc-subnet"
  ip_cidr_range            = "10.1.0.0/16"
  network                  = google_compute_network.vpc_network.name
  private_ip_google_access = true
}
resource "google_compute_firewall" "develop" {
  name    = "vpc-ssh"
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
  name    = "vpc-http"
  network = google_compute_network.vpc_network.name

  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  target_tags   = ["web"]
  source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "internal" {
  name    = "vpc-allow-internal"
  network = google_compute_network.vpc_network.name

  direction = "INGRESS"
  allow { protocol = "tcp" }
  allow { protocol = "udp" }
  allow { protocol = "icmp" }
  source_ranges = ["10.1.0.0/16"]
}

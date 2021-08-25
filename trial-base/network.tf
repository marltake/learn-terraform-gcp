resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
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

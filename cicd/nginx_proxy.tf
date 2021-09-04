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

resource "google_compute_instance" "server" {
  name         = "server"
  machine_type = "e2-micro"
  tags         = ["dev"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = 30
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.vpc_subnet.name
    access_config {}
  }
}

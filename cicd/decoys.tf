resource "google_compute_instance" "decoy" {
  name         = "decoy"
  machine_type = "f1-micro"
  tags         = ["dev"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {}
  }
  scheduling {
    preemptible         = true
    automatic_restart   = false
    on_host_maintenance = "TERMINATE"
  }
}

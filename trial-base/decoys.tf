resource "google_compute_instance" "decoy" {
  name         = "decoy"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.vpc_subnet.name
    access_config {}
  }
  scheduling {
    preemptible         = true
    automatic_restart   = false
    on_host_maintenance = "TERMINATE"
  }
}
resource "google_compute_instance" "decoy-a" {
  name         = "decoy-a"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.vpc_subnet.name
  }
  scheduling {
    preemptible         = true
    automatic_restart   = false
    on_host_maintenance = "TERMINATE"
  }
}

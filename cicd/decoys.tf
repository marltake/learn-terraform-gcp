resource "google_compute_instance" "decoy" {
  name         = "decoy"
  machine_type = "e2-micro"
  tags         = ["dev"]
  boot_disk {
    initialize_params {
      # image = "ubuntu-os-cloud/ubuntu-2004-lts"
      image = "ubuntu20-telegraf-decoy"
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
locals {
  decoys = toset(["decoy-a", "decoy-b", "decoy-c", "decoy-d"])
}
resource "google_compute_instance" "sub-decoy" {
  for_each     = local.decoys
  name         = each.value
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "ubuntu20-telegraf-decoy"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
  }
  scheduling {
    preemptible         = true
    automatic_restart   = false
    on_host_maintenance = "TERMINATE"
  }
}

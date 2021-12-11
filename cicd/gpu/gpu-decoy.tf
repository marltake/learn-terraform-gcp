resource "google_compute_instance" "gpu_decoy" {
  name         = "gpu-decoy"
  machine_type = "n1-standard-4" # "n2-standard-2" N1 or A2 but A2 is not available in Japan
  tags         = ["dev"]
  zone         = var.zone
  #zone         = "asia-northeast1-c" # GPU in -a or -c
  #Error: Error waiting for instance to create: Quota 'GPUS_ALL_REGIONS' exceeded.  Limit: 0.0 globally.
  #Quota 'PREEMPTIBLE_NVIDIA_T4_GPUS' exceeded.  Limit: 1.0 in region us-central1.
  #Quota 'PREEMPTIBLE_NVIDIA_V100_GPUS' exceeded.  Limit: 1.0 in region us-central1.
  boot_disk {
    initialize_params {
      size  = 14
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      # image = "ubuntu20-cu11-telegraf-decoy"
    }
  }
  network_interface {
    network = "default" # google_compute_network.vpc_network.name
    access_config {}
  }
  scheduling {
    #preemptible         = true
    #automatic_restart   = false
    on_host_maintenance = "TERMINATE"
  }
  allow_stopping_for_update = true
  guest_accelerator {
    type  = "nvidia-tesla-t4"
    count = 4
  }
}

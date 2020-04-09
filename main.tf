resource "google_compute_instance" "instance" {
  machine_type = var.instance_type
  name = var.instance_name
  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
      size = var.node_disk_size
    }
  }
  network_interface {
    network = var.network
    subnetwork = var.subnet
    network_ip = var.internal_ip
    access_config {
    }
  }
  metadata_startup_script = data.template_file.file.rendered
  attached_disk {
    source = google_compute_disk.disk.self_link
    mode = "READ_WRITE"
    device_name = google_compute_disk.disk.name
  }
  tags = var.tag

  depends_on = [google_compute_disk.disk]
}

resource "google_compute_disk" "disk" {
  name  = var.disk_name
  type  = "pd-standard"
  size = var.disk_size
  physical_block_size_bytes = var.disk_block_size
}

resource "google_compute_firewall" "ldap_access" {
  name = "ldap-access"
  network = var.network
  direction = "INGRESS"
  priority = 100
  source_ranges = coalescelist(var.ldap_whitelist, [data.google_compute_subnetwork.ip_cidr.ip_cidr_range])
  allow {
    protocol = "TCP"
    ports = ["389"]
  }
  allow {
    protocol = "UDP"
    ports = ["389"]
  }
  target_tags = var.tag

  depends_on = [data.google_compute_subnetwork.ip_cidr]
}

resource "google_compute_firewall" "ssh_access" {
  name = "ssh-ldap-access"
  network = var.network
  direction = "INGRESS"
  priority = 100
  source_ranges = coalescelist(var.ssh_whitelist, [data.google_compute_subnetwork.ip_cidr.ip_cidr_range])
  allow {
    protocol = "TCP"
    ports = ["22"]
  }
  target_tags = var.tag

  depends_on = [data.google_compute_subnetwork.ip_cidr]
}
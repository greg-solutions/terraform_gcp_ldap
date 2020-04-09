data "template_file" "file" {
  template = file("${path.module}/startup.sh")
  vars = {
    domain = var.domain
    domain_pass = var.domain_pass
  }
}

data google_compute_subnetwork "ip_cidr"{
  name = var.subnet
}
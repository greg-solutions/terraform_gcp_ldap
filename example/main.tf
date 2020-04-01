module "nfs" {
  source = "../"
  network = module.vpc.networks[0]
  subnet = module.vpc.subnetworks_name[0]
  disk_size = 10
  ssh_whitelist = ["94.11.34.11/32"]
  ldap_whitelist = ["10.0.0.0/16", "23.43.11.234/32"]
  internal_ip = "10.10.0.100"
  domain = "example.com"
  domain_pass = "SecurePassword1"
}
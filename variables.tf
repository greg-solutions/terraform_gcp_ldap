variable "domain" {
  type = string
  description = "(Required) Domain name for ldap controller. Example: domain.com"
}
variable "domain_pass" {
  type = string
  description = "(Required) Set password for Administrator user. !Note Password applies only once time. Module can't change password via variable."
}
variable "network" {
  type = string
  description = "(Required) Network where instance will launch"
}
variable "subnet" {
  type = string
  description = "(Required) Subnet where instance will launch"
}
variable "instance_name" {
  type = string
  description = "(Optional) Custom instance name"
  default = "ldap-server"
}
variable "instance_type" {
  type = string
  description = "(Optional) Custom instance type(size)"
  default = "n1-standard-1"
}
variable "disk_name" {
  type = string
  description = "(Optional) Custom disk name"
  default = "ldap-disk"
}
variable "node_disk_size" {
  type = number
  description = "(Optional) Custom disk size for node"
  default = 10
}
variable "disk_size" {
  type = number
  description = "(Optional) Custom disk size for nfs"
  default = 10
}
variable "disk_block_size" {
  type = number
  description = "(Optional) Custom disk block size"
  default = 4096
}
variable "ldap_whitelist" {
  type = list(string)
  description = "(Optional) Access to nfs. CIDR IP whitelist. Default is subnet addresses"
  default = []
}
variable "ssh_whitelist" {
  type = list(string)
  description = "(Optional) Access to ssh. CIDR IP whitelist. Default is subnet addresses"
  default = []
}
variable "tag" {
  type = list(string)
  description = "(Optional) Custom tag for instance & firewall rules"
  default = ["ldap"]
}
variable "internal_ip" {
  type = string
  description = "(Optional) Set custom internal ip for instance. Default is dynamic ip address."
  default = null
}
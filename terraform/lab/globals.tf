variable "vsphere_user" {
}

variable "vsphere_password" {
}

variable "vsphere_server" {
  default = "labvcs.mydomain.net"
}

variable "virtual_datacenter_name" {
  default = "lab"
}

variable "virtual_cluster_name" {
  default = "lab"
}

variable "datastore_cluster" {
  default = "lab"
}

variable "vm_folder" {
  default = "lab/my_folder"
}

variable "dns_server_1" {
  default = "192.168.1.2"
}

variable "dns_server_2" {
  default = ""
}
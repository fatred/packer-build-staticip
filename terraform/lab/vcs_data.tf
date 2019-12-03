data "vsphere_datacenter" "vsdc" {
  name = "${var.virtual_datacenter_name}"
}

data "vsphere_compute_cluster" "vscc" {
  name          = "${var.virtual_cluster_name}"
  datacenter_id = "${data.vsphere_datacenter.vsdc.id}"
}

data "vsphere_datastore_cluster" "vsdsc" {
  name          = "${var.datastore_cluster}"
  datacenter_id = "${data.vsphere_datacenter.vsdc.id}"
}

# maybe you dont have a datastore cluster. make sure you change the instance settings too...
#
# data "vsphere_datastore" "vsds" {
#   name          = "${var.datastore}"
#   datacenter_id = "${data.vsphere_datacenter.vsdc.id}"
# }

data "vsphere_network" "vnet_my_thing" {
  name          = "${var.my_vnet_name}"
  datacenter_id = "${data.vsphere_datacenter.vsdc.id}"
}


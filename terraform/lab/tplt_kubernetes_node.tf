data "vsphere_virtual_machine" "base_template" {
  name          = "packer-base-u1804"
  datacenter_id = "${data.vsphere_datacenter.vsdc.id}"
}


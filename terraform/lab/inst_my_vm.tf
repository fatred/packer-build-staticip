resource "vsphere_virtual_machine" "my_vm" {
  name                   = "my_vm_name"
  annotation             = "My VM"
  folder                 = "/${var.vm_folder}"
  resource_pool_id       = "${data.vsphere_compute_cluster.vscc.resource_pool_id}"
  datastore_cluster_id   = "${data.vsphere_datastore_cluster.vsdsc.id}"
  cpu_hot_add_enabled    = true
  memory_hot_add_enabled = true
  cpu_hot_remove_enabled = false
  enable_logging         = true
  boot_retry_delay       = 10

  num_cpus  = 2
  memory    = 4096
  guest_id  = "${data.vsphere_virtual_machine.base_template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.base_template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.vnet_my_thing.id}"
    adapter_type = "${data.vsphere_virtual_machine.base_template.network_interface_types[0]}"  
  }

  cdrom {
      client_device = true
  }
  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.base_template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.base_template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.base_template.disks.0.thin_provisioned}"
  }
  wait_for_guest_net_timeout = 30

  clone {
    template_uuid = "${data.vsphere_virtual_machine.base_template.id}"
    customize {
      timeout     = 10
      linux_options {
        host_name = "my_vm_name"
        domain    = "mydomain.net"
      }
      network_interface {
        ipv4_address = "192.168.1.100"
        ipv4_netmask = 24
      }
      dns_server_list = [ "${var.dns_server_1}","${var.dns_server_2}" ]
      ipv4_gateway    = "192.168.1.2"
    }
  }
}

output "my_vm_ip" {
  value = "${vsphere_virtual_machine.my_vm.default_ip_address}"
}
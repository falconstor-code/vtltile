data "template_file" "init" {
  template = "${file("Vyatta_inter.sh")}"
  vars = {
    private_ipv4_address= "ibm_network_gateway.gateway.private_ipv4_address"
  }
}

resource "ibm_compute_ssh_key" "hce_ssh_key" {
    label      = var.label
    public_key = var.public_key
}

resource "ibm_network_gateway" "gateway" {
  name = var.vyatta_details.name

  members {
    hostname             = var.vyatta_details.hostname
    domain               = "IBM-PoC-FalconStor-Migration-and-Backup.cloud"
    datacenter           = var.vyatta_details.datacenter
    network_speed        = var.vyatta_details.network_speed
    package_key_name     = "VIRTUAL_ROUTER_APPLIANCE_10_GPBS" 
    private_network_only = false
    tcp_monitoring       = true
    process_key_name     = "INTEL_XEON_5218_2_30"
    os_key_name          = "OS_VIRTUAL_ROUTER_APPLIANCE_20_X_UP_TO_20_GBPS_SUBSCRIPTION_EDITION_64_BIT"
    redundant_network    = false
    disk_key_names       = ["HARD_DRIVE_4_00_TB_SATA"]
    public_bandwidth     = var.vyatta_details.public_bandwidth
    memory               = var.vyatta_details.memory
    ipv6_enabled         = true
    ssh_key_ids          = [ibm_compute_ssh_key.hce_ssh_key.id]
    user_metadata        = "${file("Vyatta_inter.sh")}"
  }
}


resource "ibm_network_vlan" "test_vlan" {
  name            = var.vlan_details.name
  datacenter      = var.vlan_details.datacenter
  type            = var.vlan_details.type
  
}

resource "ibm_network_gateway_vlan_association" "gateway_vlan_association" {
  gateway_id      = ibm_network_gateway.gateway.id
  network_vlan_id = ibm_network_vlan.test_vlan.id

}




# VTL tile Instance Creation 

locals {
  pvs_info = split(":", var.crn)
  location = local.pvs_info[5]
  region   = can(regex("-", local.location)) ? (can(regex("-[0-9]+$", local.location)) ? replace(local.location, regex("-[0-9]+$", local.location), "") : local.location) : (can(regex("[0-9]+$", local.location)) ? replace(local.location, regex("[0-9]+$", local.location), "") : local.location)
  pid      = local.pvs_info[7]
}

data "ibm_pi_catalog_images" "catalog_images" {
  sap                  = true
  vtl                  = true
  pi_cloud_instance_id = local.pid
}
data "ibm_pi_images" "cloud_instance_images" {
  pi_cloud_instance_id = local.pid
}
data "ibm_pi_placement_groups" "cloud_instance_groups" {
  pi_cloud_instance_id = local.pid
}
resource "ibm_pi_key" "sshkeys" {
  pi_cloud_instance_id = local.pid
  pi_key_name          = var.ssh_pi_details.pi_key_name         
  pi_ssh_key           = var.ssh_pi_details.pi_ssh_key
}


resource "ibm_pi_network" "power_network_1" {
  pi_network_name      = var.pi_network_1_details.pi_network_name
  pi_cloud_instance_id = local.pid
  pi_network_type      = "vlan"
  pi_cidr              = var.pi_network_1_details.pi_cidr
  pi_gateway           = var.pi_network_1_details.pi_gateway
  
}

resource "ibm_pi_network" "power_network_2" {
  pi_network_name      = var.pi_network_2_details.pi_network_name
  pi_cloud_instance_id = local.pid
  pi_network_type      = "vlan"
  pi_cidr              = var.pi_network_2_details.pi_cidr
  pi_gateway           = var.pi_network_2_details.pi_gateway
  
}

resource "ibm_pi_network" "power_network_3" {
  pi_network_name      = var.pi_network_3_details.pi_network_name
  pi_cloud_instance_id = local.pid
  pi_network_type      = "vlan"
  pi_cidr              = var.pi_network_3_details.pi_cidr
  pi_gateway           = var.pi_network_3_details.pi_gateway
  
}

data "ibm_pi_network" "network_1" {
  pi_cloud_instance_id = local.pid
  pi_network_name      = ibm_pi_network.power_network_1.pi_network_name
}
data "ibm_pi_network" "network_2" {
  count = length(var.networks.network_2) > 0 ? 1 : 0
  pi_cloud_instance_id = local.pid
  pi_network_name      = ibm_pi_network.power_network_2.pi_network_name
}
data "ibm_pi_network" "network_3" {
  count = length(var.networks.network_3) > 0 ? 1 : 0
  pi_cloud_instance_id = local.pid
  pi_network_name      = ibm_pi_network.power_network_3.pi_network_name
}
locals {
  stock_image_name = "VTL-FalconStor-10_03-001"
  catalog_image = [for x in data.ibm_pi_catalog_images.catalog_images.images : x if x.name == local.stock_image_name]
  private_image = [for x in data.ibm_pi_images.cloud_instance_images.image_info : x if x.name == local.stock_image_name]
  private_image_id = length(local.private_image) > 0 ? local.private_image[0].id  : ""
  placement_group = [for x in data.ibm_pi_placement_groups.cloud_instance_groups.placement_groups : x if x.name == var.placement_group]
  placement_group_id = length(local.placement_group) > 0 ? local.placement_group[0].id : ""
}

resource "ibm_pi_image" "stock_image_copy" {
  count = length(local.private_image_id) == 0 ? 1 : 0
  pi_image_name       = local.stock_image_name
  pi_image_id         = local.catalog_image[0].image_id
  pi_cloud_instance_id = local.pid
}

resource "ibm_pi_instance" "instance" {
  pi_cloud_instance_id = local.pid
  pi_memory            = var.VTL_details.pi_memory
  pi_processors        = var.VTL_details.pi_processors
  pi_instance_name     = var.VTL_details.pi_instance_name
  pi_proc_type         = var.VTL_details.pi_proc_type
  pi_image_id          = length(local.private_image_id) == 0 ? ibm_pi_image.stock_image_copy[0].image_id : local.private_image_id
  pi_key_pair_name     = ibm_pi_key.sshkeys.id
  pi_sys_type          = var.VTL_details.pi_sys_type
  pi_storage_type      = var.VTL_details.pi_storage_type
  pi_affinity_policy   = length(var.pvm_instances) > 0 ? var.affinity_policy : null
  pi_anti_affinity_instances = length(var.pvm_instances) > 0 ? split(",", var.pvm_instances) : null
  pi_placement_group_id = local.placement_group_id
  pi_license_repository_capacity = var.license_repository_capacity
  pi_network {
    network_id = data.ibm_pi_network.network_1.id
    ip_address                   = var.ip_address1
  }
  dynamic "pi_network" {
    for_each = var.networks.network_2 == "" ? [] : [1]
    content {
      network_id = data.ibm_pi_network.network_2[0].id
      ip_address = var.ip_address2
    }
  }
  dynamic "pi_network" {
    for_each = var.networks.network_3 == "" ? [] : [1]
    content {
      network_id = data.ibm_pi_network.network_3[0].id
      ip_address = var.ip_address3
    }
  }

}



#Cos server creation proxy \ any other
data "template_file" "init" {
  template = "${file("pi_static_route.sh")}"
  vars = {
    ipv4_address_private= "ibm_compute_vm_instance.twc_terraform_sample.ipv4_address_private"
  }
}

resource "ibm_compute_ssh_key" "proxy_ssh_key" {
    label      = var.ssh_ci_details.label
    public_key = var.ssh_ci_details.public_key
}

resource "ibm_compute_vm_instance" "twc_terraform_sample" {
  hostname                   = var.proxy_server_details.hostname
  domain                     = var.proxy_server_details.domain
  os_reference_code          = var.proxy_server_details.os_reference_code
  datacenter                 = var.proxy_server_details.datacenter
  network_speed              = var.proxy_server_details.network_speed
  hourly_billing             = true
  private_network_only       = false
  cores                      = var.proxy_server_details.cores
  memory                     = var.proxy_server_details.memory
  disks                      = [25, 10, 20]
  user_metadata              = "${file("install_nginx.sh")}"
  local_disk                 = false
  ssh_key_ids                =  [ibm_compute_ssh_key.proxy_ssh_key.id]
}

#Cloud connection creation 
resource "ibm_pi_cloud_connection" "cloud_connection" {
  pi_cloud_instance_id        = var.cloud_connection_details.pi_cloud_instance_id
  pi_cloud_connection_name    = var.cloud_connection_details.pi_cloud_connection_name
  pi_cloud_connection_classic_enabled = true
  pi_cloud_connection_metered = true
  pi_cloud_connection_speed    = var.cloud_connection_details.pi_cloud_connection_speed
  pi_cloud_connection_gre_cidr = var.cloud_connection_details.pi_cloud_connection_gre_cidr
  pi_cloud_connection_gre_destination_address= ibm_network_gateway.gateway.private_ipv4_address
}





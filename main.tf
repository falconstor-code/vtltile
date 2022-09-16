resource "ibm_compute_ssh_key" "hce_ssh_key" {
    label      = var.SSH-key-name-vyatta
    public_key = var.public_key_for_vyatta
}

data "ibm_compute_ssh_key" "public_key" {
    label = ibm_compute_ssh_key.hce_ssh_key.label
}

resource "ibm_network_gateway" "gateway" {
  name = var.name

  members {
    hostname             = var.name
    domain               = var.domain
    datacenter           = var.datacenter
    network_speed        = var.network_speed
    package_key_name     = "VIRTUAL_ROUTER_APPLIANCE_10_GPBS" 
    private_network_only = false
    tcp_monitoring       = true
    process_key_name     = "INTEL_XEON_5218_2_30"
    os_key_name          = "OS_VIRTUAL_ROUTER_APPLIANCE_20_X_UP_TO_20_GBPS_SUBSCRIPTION_EDITION_64_BIT"
    redundant_network    = false
    disk_key_names       = ["HARD_DRIVE_4_00_TB_SATA"]
    public_bandwidth     = var.public_bandwidth
    memory               = var.memory
    ipv6_enabled         = true
    ssh_key_ids          = [data.ibm_compute_ssh_key.public_key.id]
    user_metadata        = "${file("Vyatta_inter.sh")}"
  }
}

resource "ibm_network_vlan" "test_vlan" {
  name            = var.vlan_name
  datacenter      = var.vlan_datacenter
  type            = var.vlan_type
  
}

resource "ibm_network_gateway_vlan_association" "gateway_vlan_association" {
  gateway_id      = ibm_network_gateway.gateway.id
  network_vlan_id = ibm_network_vlan.test_vlan.id

}

data "ibm_network_vlan" "vlan" {
    name = ibm_network_vlan.test_vlan.name
}

# VTL tile Instance Creation 



data "ibm_pi_catalog_images" "catalog_images" {
  provider             = ibm.tile
  sap                  = true
  vtl                  = true
  pi_cloud_instance_id = local.pid
}
data "ibm_pi_images" "cloud_instance_images" {
  provider             = ibm.tile
  pi_cloud_instance_id = local.pid
}
data "ibm_pi_placement_groups" "cloud_instance_groups" {
  provider             = ibm.tile
  pi_cloud_instance_id = local.pid
}
resource "ibm_pi_key" "sshkeys" {
  provider             = ibm.tile
  pi_cloud_instance_id = local.pid
  pi_key_name          = var.pi_key_name         
  pi_ssh_key           = var.pi_ssh_key
}


resource "ibm_pi_network" "power_network_1" {
  provider             = ibm.tile
  pi_network_name      = var.pi_network_name_1
  pi_cloud_instance_id = local.pid
  pi_network_type      = "vlan"
  pi_cidr              = var.pi_cidr_1
  pi_gateway           = var.pi_gateway_1
  
}

resource "ibm_pi_network" "power_network_2" {
  provider             = ibm.tile
  pi_network_name      = var.pi_network_name_2
  pi_cloud_instance_id = local.pid
  pi_network_type      = "vlan"
  pi_cidr              = var.pi_cidr_2
  pi_gateway           = var.pi_gateway_2
  
}

resource "ibm_pi_network" "power_network_3" {
  provider             = ibm.tile
  pi_network_name      = var.pi_network_name_3
  pi_cloud_instance_id = local.pid
  pi_network_type      = "vlan"
  pi_cidr              = var.pi_cidr_3
  pi_gateway           = var.pi_gateway_3
  
}

data "ibm_pi_network" "network_1" {
  provider             = ibm.tile
  pi_cloud_instance_id = local.pid
  pi_network_name      = ibm_pi_network.power_network_1.pi_network_name
}
data "ibm_pi_network" "network_2" {
  provider             = ibm.tile
  count = length(var.pi_network_name_2) > 0 ? 1 : 0
  pi_cloud_instance_id = local.pid
  pi_network_name      = ibm_pi_network.power_network_2.pi_network_name
}
data "ibm_pi_network" "network_3" {
  provider             = ibm.tile
  count = length(var.pi_network_name_3) > 0 ? 1 : 0
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
  provider             = ibm.tile
  count = length(local.private_image_id) == 0 ? 1 : 0
  pi_image_name       = local.stock_image_name
  pi_image_id         = local.catalog_image[0].image_id
  pi_cloud_instance_id = local.pid
}

resource "ibm_pi_instance" "instance" {
  provider             = ibm.tile
  pi_cloud_instance_id = local.pid
  pi_memory            = var.pi_memory
  pi_processors        = var.pi_processors
  pi_instance_name     = var.pi_instance_name
  pi_proc_type         = var.pi_proc_type
  pi_image_id          = length(local.private_image_id) == 0 ? ibm_pi_image.stock_image_copy[0].image_id : local.private_image_id
  pi_key_pair_name     = ibm_pi_key.sshkeys.id
  pi_sys_type          = var.pi_sys_type
  pi_storage_type      = var.pi_storage_type
  pi_affinity_policy   = length(var.pvm_instances) > 0 ? var.affinity_policy : null
  pi_anti_affinity_instances = length(var.pvm_instances) > 0 ? split(",", var.pvm_instances) : null
  pi_placement_group_id = local.placement_group_id
  pi_license_repository_capacity = var.license_repository_capacity
  pi_network {
    network_id = data.ibm_pi_network.network_1.id
    ip_address                   = var.ip_address1
  }
  dynamic "pi_network" {
    for_each = var.pi_network_name_2 == "" ? [] : [1]
    content {
      network_id = data.ibm_pi_network.network_2[0].id
      ip_address = var.ip_address2
    }
  }
  dynamic "pi_network" {
    for_each = var.pi_network_name_3 == "" ? [] : [1]
    content {
      network_id = data.ibm_pi_network.network_3[0].id
      ip_address = var.ip_address3
    }
  }

}



#Cos server creation proxy \ any other

resource "ibm_compute_ssh_key" "proxy_ssh_key" {
    label      = var.label_proxy
    public_key = var.public_key_proxy
}

resource "ibm_compute_vm_instance" "twc_terraform_sample" {
  hostname                   = var.hostname-proxy
  domain                     = var.domain-proxy
  os_reference_code          = var.os_reference_code-proxy
  datacenter                 = var.datacenter-proxy
  network_speed              = var.network_speed-proxy
  hourly_billing             = true
  private_network_only       = false
  cores                      = var.cores-proxy
  memory                     = var.memory-proxy
  disks                      = [25, 10, 20]
  user_metadata              = "${file("install_nginx.sh")}"
  local_disk                 = false
  private_vlan_id            = data.ibm_network_vlan.vlan.id
  ssh_key_ids                =  [ibm_compute_ssh_key.proxy_ssh_key.id]
}

#Cloud connection creation 
resource "ibm_pi_cloud_connection" "cloud_connection" {
  provider                   = ibm.tile
  pi_cloud_instance_id        = local.pid
  pi_cloud_connection_name    = var.pi_cloud_connection_name
  pi_cloud_connection_classic_enabled = true
  pi_cloud_connection_networks = [data.ibm_pi_network.network_1.pi_network_name]
  pi_cloud_connection_metered = true
  pi_cloud_connection_speed    = var.pi_cloud_connection_speed
  pi_cloud_connection_gre_cidr = var.pi_cloud_connection_gre_cidr
  pi_cloud_connection_gre_destination_address= ibm_network_gateway.gateway.private_ipv4_address
}





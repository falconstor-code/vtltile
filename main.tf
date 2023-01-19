resource "ibm_network_vlan" "test_vlan" {
  name            = var.vlan_name
  datacenter      = var.vlan_datacenter
  type            = var.vlan_type
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
  pi_key_name          = var.vtl_SSHkey_name         
  pi_ssh_key           = var.vtl_public_key
}


resource "ibm_pi_network" "power_network_1" {
  provider             = ibm.tile
  pi_network_name      = var.vtl_network1_name
  pi_cloud_instance_id = local.pid
  pi_network_type      = "vlan"
  pi_cidr              = var.vtl_network1_cidr
  pi_gateway           = var.vtl_network1_gateway
}

resource "ibm_pi_network" "power_network_2" {
  provider             = ibm.tile
  count = length(var.vtl_network2_name) > 0 ? 1 : 0
  pi_network_name      = var.vtl_network2_name
  pi_cloud_instance_id = local.pid
  pi_network_type      = "vlan"
  pi_cidr              = var.vtl_network2_cidr
  pi_gateway           = var.vtl_network2_gateway
}

resource "ibm_pi_network" "power_network_3" {
  provider             = ibm.tile
  count = length(var.vtl_network3_name) > 0 ? 1 : 0
  pi_network_name      = var.vtl_network3_name
  pi_cloud_instance_id = local.pid
  pi_network_type      = "vlan"
  pi_cidr              = var.vtl_network3_cidr
  pi_gateway           = var.vtl_network3_gateway
}

data "ibm_pi_network" "network_1" {
  provider             = ibm.tile
  pi_cloud_instance_id = local.pid
  pi_network_name      = ibm_pi_network.power_network_1.pi_network_name
}

data "ibm_pi_network" "network_2" {
  provider             = ibm.tile
  count = length(var.vtl_network2_name) > 0 ? 1 : 0
  pi_cloud_instance_id = local.pid
  pi_network_name      = ibm_pi_network.power_network_2[0].pi_network_name
}

data "ibm_pi_network" "network_3" {
  provider             = ibm.tile
  count = length(var.vtl_network3_name) > 0 ? 1 : 0
  pi_cloud_instance_id = local.pid
  pi_network_name      = ibm_pi_network.power_network_3[0].pi_network_name
}

locals {
  stock_image_name = "VTL-FalconStor-10_03-001"
  catalog_image = [for x in data.ibm_pi_catalog_images.catalog_images.images : x if x.name == local.stock_image_name]
  private_image = [for x in data.ibm_pi_images.cloud_instance_images.image_info : x if x.name == local.stock_image_name]
  private_image_id = length(local.private_image) > 0 ? local.private_image[0].id  : ""
  placement_group = [for x in data.ibm_pi_placement_groups.cloud_instance_groups.placement_groups : x if x.name == var.vtl_placement_group]
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
  pi_memory            = var.vtl_memory
  pi_processors        = var.vtl_processors
  pi_instance_name     = var.vtl_instance_name
  pi_proc_type         = var.vtl_processor_type
  pi_image_id          = length(local.private_image_id) == 0 ? ibm_pi_image.stock_image_copy[0].image_id : local.private_image_id
  pi_key_pair_name     = ibm_pi_key.sshkeys.pi_key_name
  pi_sys_type          = var.vtl_sys_type
  pi_storage_type      = var.vtl_storage_type
  pi_health_status     = "WARNING"
  pi_storage_pool      = "Tier1-Flash-2"
  pi_placement_group_id = local.placement_group_id
  pi_license_repository_capacity = var.vtl_licensed_repository_capacity
  pi_network {
    network_id = data.ibm_pi_network.network_1.id
    ip_address = length(var.vtl_network1_ip_address) > 0 ? var.vtl_network1_ip_address : ""
  }
  dynamic "pi_network" {
    for_each = var.vtl_network2_name == "" ? [] : [1]
    content {
      network_id = data.ibm_pi_network.network_2[0].id
      ip_address = length(var.vtl_network2_ip_address) > 0 ? var.vtl_network2_ip_address : ""
    }
  }
  dynamic "pi_network" {
    for_each = var.vtl_network3_name == "" ? [] : [1]
    content {
      network_id = data.ibm_pi_network.network_3[0].id
      ip_address = length(var.vtl_network3_ip_address) > 0 ? var.vtl_network3_ip_address : ""
    }
  }
}


# Cos server creation proxy \ any other
resource "ibm_compute_ssh_key" "proxy_ssh_key" {
    label      = var.proxy_SSHkey_name
    public_key = var.proxy_public_key
}

resource "ibm_compute_vm_instance" "twc_terraform_sample" {
  hostname                   = var.proxy_hostname
  domain                     = var.proxy_domain
  os_reference_code          = var.proxy_os
  datacenter                 = ibm_network_vlan.test_vlan.datacenter
  network_speed              = var.proxy_speed
  hourly_billing             = true
  private_network_only       = false
  cores                      = var.proxy_cores
  memory                     = var.proxy_memory
  disks                      = [25, 10, 20]
  user_metadata              = "${file("install_nginx.sh")}"
  local_disk                 = false
  ssh_key_ids                =  [ibm_compute_ssh_key.proxy_ssh_key.id]
  private_vlan_id            = data.ibm_network_vlan.vlan.id
}

#Cloud connection creation 
resource "ibm_pi_cloud_connection" "cloud_connection" {
  provider                   = ibm.tile
  pi_cloud_instance_id        = local.pid
  pi_cloud_connection_name    = var.cloud_connection_name
  pi_cloud_connection_classic_enabled = false
  pi_cloud_connection_metered = true
  pi_cloud_connection_speed   = var.cloud_connection_speed
}

    resource "ibm_pi_volume" "configuration_volume"{
  pi_volume_size       = var.volume_configuration_size
  pi_volume_name       = "${var.instance_name}_configuration-volume"
  pi_volume_type       = var.storage_type
  pi_volume_shareable  = true
  pi_cloud_instance_id = local.pid
}
data "ibm_pi_volume" "configuration_volume" {
  pi_volume_name       = ibm_pi_volume.configuration_volume.pi_volume_name
  pi_cloud_instance_id = local.pid
}

resource "ibm_pi_volume" "index_volume"{
  pi_volume_size       = var.volume_index_size
  pi_volume_name       = "${var.instance_name}_index-volume"
  pi_volume_type       = var.storage_type
  pi_volume_shareable  = true
  pi_cloud_instance_id = local.pid
}
data "ibm_pi_volume" "index_volume" {
  pi_volume_name       = ibm_pi_volume.index_volume.pi_volume_name
  pi_cloud_instance_id = local.pid
}

resource "ibm_pi_volume" "tape_volume"{
  pi_volume_size       = var.volume_tape_size
  pi_volume_name       = "${var.instance_name}_tape-volume"
  pi_volume_type       = var.storage_type
  pi_volume_shareable  = true
  pi_cloud_instance_id = local.pid
}
data "ibm_pi_volume" "tape_volume" {
  pi_volume_name       = ibm_pi_volume.tape_volume.pi_volume_name
  pi_cloud_instance_id = local.pid
}

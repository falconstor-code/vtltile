variable "prefix" {
  description = "A unique identifier for resources. Must begin with a lowercase letter and end with a lowerccase letter or number. This prefix will be prepended to any resources provisioned by this template. Prefixes must be 16 or fewer characters."
  type        = string
  default     = ""

  validation {
    error_message = "Prefix must begin with a lowercase letter and contain only lowercase letters, numbers, and - characters. Prefixes must end with a lowercase letter or number and be 16 or fewer characters."
    condition     = can(regex("^([a-z]|[a-z][-a-z0-9]*[a-z0-9])$", var.prefix)) && length(var.prefix) <= 16
  }
}


variable "ibmcloud_api_key" {
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources."
  type        = string
  sensitive   = true
  default     = ""
}

variable "region" {
  description = "Region where VPC will be created. To find your VPC region, use `ibmcloud is regions` command to list available regions."
  type        = string
  default     = ""
}

variable "zone" {
  description = "Zone where VPC will be created, for example, jp-tok-1, us-south-1, etc."
  type        = string
  default     = ""
}

variable "powervs_zone" {
  description = "IBM Cloud data center location where IBM PowerVS infrastructure will be created."
  type        = string
  default     = ""
}

variable "windows_ssh_publickey" {
  type        = string
  default     = ""
  description = "Windows public key for SSH key creation"
}

variable "squid_ssh_publickey" {
  type        = string
  default     = ""
  description = "Option to create a Squid proxy server if the SSH public key is specified; if not, a squid server will not be created"
}

variable "vtl_public_key" {
  type        = string
  default     = ""
  description = "VTL public key for SSH key creation"
}

variable "IBMI_ssh_publickey" {
  type        = string
  default     = ""
  description = "IBM i public key for SSH key creation"
}

variable "AIX_ssh_publickey" {
  type        = string
  default     = ""
  description = "AIX public key for SSH key creation"
}

variable "linux_ssh_publickey" {
  type        = string
  default     = ""
  description = "Linux public key for SSH key creation"
}

variable "powervs_resource_group_name" {
  description = "Existing IBM Cloud resource group name"
  type        = string
  default     = "Default"

}

variable "powervs_management_network" {
  description = "Name and CIDR of the IBM Cloud PowerVS management network subnet to create"
  type = object({
    name = string
    cidr = string
  })
  default = {
    name = "mgmt_net"
    cidr = "10.51.0.0/24"
  }
}

variable "powervs_backup_network" {
  description = "Name and CIDR of the IBM Cloud PowerVS backup network subnet to create."
  type = object({
    name = string
    cidr = string
  })
  default = {
    name = "bkp_net"
    cidr = "10.52.0.0/24"
  }
}

variable "cloud_connection" {
  description = "Cloud connection parameters: Speed (50, 100, 200, 500, 1000, 2000, 5000, 10000 Mb/s), Count (1 or 2 connections), Global Routing (true or false), Metered (true or false)"
  type = object({
    speed          = number
    global_routing = bool
    metered        = bool
  })

  default = {
    speed          = 5000
    global_routing = true
    metered        = true
  }
}

variable "vtl_index_volume_size" {
  type        = number
  default     = 20
  description = "The size of the block storage volume for the index of VTL Deduplication Repository in GB; the maximum size of a volume is 2 TB"
}

variable "vtl_tape_volume_size" {
  type        = number
  default     = 20
  description = "The size of the block storage volume for VTL tape backup cache in GB; the maximum size of a volume is 2 TB"
}

variable "vtl_configuration_volume_size" {
  type        = number
  default     =20
  description = "The size of the block storage volume for VTL Configuration Repository in GB"
}

variable "vtl_memory" {
  type        = number
  default     = 18
  description = "The amount of memory to assign to the VTL instance in GB according to the following formula: memory >= 16 + (2 * license_repository_capacity)"
}

variable "vtl_processors" {
  type        = number
  default     = 2
  description = "The number of vCPUs, AKA virtual processors, to assign to the VTL instance; one vCPU is equal to one physical CPU core."
}

variable "vtl_processor_type" {
  type        = string
  default     = "shared"
  description = "The type of processor mode in which the VTL will run: 'shared', 'capped', or 'dedicated'"
}

variable "vtl_sys_type" {
  type        = string
  default     = "s922"
  description = "The type of system on which to create the VTL: 's922', 'e980'"
}

variable "vtl_storage_type" {
  type        = string
  default     = "tier3"
  description = "The type of storage tier for used volumes: 'tier1' (high performance) or 'tier3'"
}

variable "vtl_public_network_name" {
  type        = string
  default     = ""
  description = "The first network ID or name to assign to the VTL instance"
}

variable "vtl_public_cidr" {
  type        = string
  default     = ""
  description = "The first network IP addresse range"
}

variable "vtl_public_gateway" {
  type        = string
  default     = ""
  description = "The first network gateway IP address"
}

variable "powervs_image_names" {
  description = "List of images to be imported into cloud account from the IBM catalog images"
  type        = list(string)
  default     = ["RHEL8-SP6","7200-05-05","IBMi-72-09-2924-8"]
}

variable "powervs_os_image_name1" {
  description = "OS image 1 name for a PowerVS Instance"
  type        = string
  default     = "RHEL8-SP6"
}

variable "powervs_os_image_name2" {
  description = "OS image 2 name for a PowerVS Instance"
  type        = string
  default     = "7200-05-05"
}

variable "powervs_os_image_name3" {
  description = "OS image 2 name for a PowerVS Instance"
  type        = string
  default     = "IBMi-72-09-2924-8"
}

variable "IBMI_memory" {
  type        = number
  default     = 18
  description = "The amount of memory to assign to the IBM i instance in GB"
}

variable "IBMI_processors" {
  type        = number
  default     = 2
  description = "The number of vCPUs, AKA virtual processors, to assign to the IBM i virtual machine instance"
}

variable "IBMI_proc_type" {
  type        = string
  default     = "shared"
  description = "IBMI_proc_type"
}

variable "IBMI_sys_type" {
  type        = string
  default     = "s922"
  description = "IBMI_sys_type"
}

variable "IBMI_storage_type" {
  type        = string
  default     = "tier3"
  description = "Type of storage tier to assign to the VTL instance based on required performance: 'tier1' or 'tier3'"
}

variable "AIX_memory" {
  type        = number
  default     = 18
  description = "The amount of memory to assign to the AIX instance in GB"
}

variable "AIX_processors" {
  type        = number
  default     = 2
  description = "The number of vCPUs, AKA virtual processors, to assign to the AIX virtual machine instance"
}

variable "AIX_proc_type" {
  type        = string
  default     = "shared"
  description = "AIX_proc_type"
}

variable "AIX_sys_type" {
  type        = string
  default     = "s922"
  description = "AIX_sys_type"
}

variable "AIX_storage_type" {
  type        = string
  default     = "tier3"
  description = "Type of storage tier to assign to the VTL instance based on required performance: 'tier1' or 'tier3'"
}

variable "linux_memory" {
  type        = number
  default     = 18
  description = "The amount of memory to assign to the Linux instance in GB"
}

variable "linux_processors" {
  type        = number
  default     = 2
  description = "The number of vCPUs, AKA virtual processors, to assign to the Linux virtual machine instance"
}

variable "linux_proc_type" {
  type        = string
  default     = "shared"
  description = "linux_proc_type"
}

variable "linux_sys_type" {
  type        = string
  default     = "s922"
  description = "linux_sys_type"
}

variable "linux_storage_type" {
  type        = string
  default     = "tier3"
  description = "Type of storage tier to assign to the VTL instance based on required performance: 'tier1' or 'tier3'"
}

variable "peer_cidrs" {
  description = "CIDR's of the peer to connect to the gateway, it is required parameter as you provide the mode of VPN gateway"
  type        = list(string)
  default     = [""]
}

variable "mode" {
  description = "If you provide the MODE parameter it is going to create the VPN gateway otherwise it will not create "
  type        = string
  default     = ""
}






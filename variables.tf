# Classic infrastructure details
variable "classic_region" {
  type        = string
  default     = ""
  description = "Classic infrastructure region"
}

variable "classic_zone" {
  type        = string
  default     = ""
  description = "Classic infrastructure zone"
}

variable "classic_username" {
  type        = string
  default     = ""
  description = "Classic infrastructure Softlayer username"
}

variable "classic_api_key" {
  type        = string
  default     = ""
  description = "Classic infrastructure API key"
}

variable "vlan_name" {
  type        = string
  default     = "FS_DRaas_vlan_name"
  description = "VLAN name"
}

variable "vlan_datacenter" {
  type        = string
  default     = "tok04"
  description = "VLAN datacenter"
}

variable "vlan_type" {
  type        = string
  default     = "PRIVATE"
  description = "VLAN type: 'PRIVATE', 'PUBLIC'"
}

# COS proxy server details in Classic infrastructure
variable "proxy_SSHkey_name" {
  type        = string
  default     = ""
  description = "Name of the SSH key for the proxy server"
}
 
variable "proxy_public_key" {
  type        = string
  default     = ""
  description = "Proxy server public key ffor SSH key creation"
}

variable "proxy_hostname" {
  type        = string
  default     = "FS.DRaaS.proxy.hostname"
  description = "Proxy server hostname"
}

variable "proxy_domain" {
  type        = string
  default     = "FS.DRaaS.proxy.domain"
  description = "Proxy server domain name"
}

variable "proxy_os" {
  type        = string
  default     = "CENTOS_7_64"
  description = "Proxy server OS reference code"
}

variable "proxy_speed" {
  type        = number
  default     = 100
  description = "Proxy server network speed in Mb/s"
}

variable "proxy_cores" {
  type        = number
  default     = 2
  description = "Number of CPU cores to allocate for the proxy server"
}

variable "proxy_memory" {
  type        = number
  default     = 4096
  description = "Proxy server memory amount in MB"
}


# IBM API key in Power infrastructure 
variable "ibmcloud_api_key" {
  type        = string
  default     = ""
  description = "IBM Cloud API key"
}


# Cloud connection details in Power infrastructure
variable "cloud_connection_name" {
  type        = string
  default     = "FS_DRaaS_cloud_connection"
  description = "Name of the direct link in Power infrastructure to connect to Classic infrastructure using Generic Routing Encapsulation (GRE) tunnel"
}

variable "cloud_connection_speed" {
  type        = number
  default     = 500
  description = "Cloud connection speed in Mb/s"
}


# VTL tile details in Power infrastructure
variable "vtl_SSHkey_name" {
  type        = string
  default     = ""
  description = "VTL SSH key name"
}

variable "vtl_public_key" {
  type        = string
  default     = ""
  description = "VTL public key for SSH key creation"
}

variable "vtl_crn" {
  type        = string
  default     = ""
  description = "VTL Power Systems Virtual Server Cloud Resource Name (CRN)"
}

variable "vtl_instance_name" {
  type        = string
  default     = ""
  description = "VTL instance name"
}

variable "vtl_memory" {
  type        = number
  default     = 18
  description = "VTL memory amount in GB; it should be >= 16 + (2 * licensed_repository_capacity)"
}

variable "vtl_processors" {
  type        = number
  default     = 2
  description = "Number of CPU cores to allocate for VTL instance"
}

variable "vtl_processor_type" {
  type        = string
  default     = "shared"
  description = "VTL processor type: 'shared', 'capped', or 'dedicated'"
}

variable "vtl_sys_type" {
  type        = string
  default     = "s922"
  description = "Type of storage tier to assign to the VTL instance based on required performance: 'tier1' or 'tier3'"
}

variable "vtl_storage_type" {
  type        = string
  default     = "tier1"
  description = "Type of system on which to create the VTL instance: 's922', 'e880', 'e980', 'e1080', or 's1022'"
}

variable "vtl_licensed_repository_capacity" {
  type        = number
  default     = 1
  description = "VTL licensed repository capacity in TB"
}

variable "vtl_network1_name" {
  type        = string
  default     = ""
  description = "First network ID or name to assign to the VTL instance"
}

variable "vtl_network1_cidr" {
  type        = string
  default     = ""
  description = "First network IP addresse range"
}

variable "vtl_network1_gateway" {
  type        = string
  default     = ""
  description = "First network gateway IP address"
}

variable "vtl_network1_ip_address" {
  type        = string
  default     = ""
  description = "Specific IP address to assign to the first network rather than automatic assignment within the IP range"
}

variable "vtl_network2_name" {
  type        = string
  default     = ""
  description = "Second network ID or name to assign to the VTL instance"
}

variable "vtl_network2_cidr" {
  type        = string
  default     = ""
  description = "Second network IP addresse range"
}

variable "vtl_network2_gateway" {
  type        = string
  default     = ""
  description = "Second network gateway IP address"
}

variable "vtl_network2_ip_address" {
  type        = string
  default     = ""
  description = "Specific IP address to assign to the second network rather than automatic assignment within the IP range"
}

variable "vtl_network3_name" {
  type        = string
  default     = ""
  description = "Third network ID or name to assign to the VTL instance"
}

variable "vtl_network3_cidr" {
  type        = string
  default     = ""
  description = "Third network IP addresse range"
}

variable "vtl_network3_gateway" {
  type        = string
  default     = ""
  description = "Third network gateway IP address"
}

variable "vtl_network3_ip_address" {
  type        = string
  default     = ""
  description = "Specific IP address to assign to the third network rather than automatic assignment within the IP range"
}

variable "vtl_placement_group" {
  type        = string
  default     = ""
  description = "Server group name where the VTL instance will be placed, as defined for the selected Power Systems Virtual Server CRN"
}

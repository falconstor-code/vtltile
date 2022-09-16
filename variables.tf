#Vyatta router details. 
 #ssh key details
variable "SSH-key-name-vyatta" {
  type        = string
  default     = ""
  description = "name of the ssh key for proxy server"

}

variable "public_key_for_vyatta" {
  type        = string
  default     = ""
  description = "public_ key for the ssh key"

}

 #router details

variable "name" {
  type        = string
  default     = ""
  description = "vyatta_name"
}

variable "domain"{
  type        = string
  default     = ""
  description = "vyatta_domain"
}

variable "hostname" {
  type        = string
  default     = ""
  description = "vyatta_hostname"
}

variable "datacenter" {
  type        = string
  default     = ""
  description = "vyatta_datacenter"
}

variable "network_speed" {
  type        = number
  default     = 1000
  description = "vyatta_network_speed_in Mbps"
}

variable "public_bandwidth" {
  type        = number
  default     = 20000
  description = "vyatta_public_bandwidth_Allowed public network traffic (in GB) per month"
}

variable "memory" {
  type        = number
  default     = 64
  description = "vyatta_memory"
}

 #vlan details

variable "vlan_name" {
  type        = string
  default     = ""
  description = "vlan_name"
}

variable "vlan_datacenter" {
  type        = string
  default     = ""
  description = "vlan_datacenter"
}

variable "vlan_type" {
  type        = string
  default     = ""
  description = "vlan_type"
}

#vtl-tile-instance-details
variable "pi_key_name" {
  type        = string
  default     = ""
  description = "pi key name for the creation of ssh key for VTL in power vs"
}

variable "pi_ssh_key" {
  type        = string
  default     = ""
  description = "public key for the creation of ssh key for VTL in power vs"
}

variable "crn" {
  type        = string
  default     = ""
}

variable "pi_instance_name" {
  type        = string
  default     = ""
  description = "vtl_pi_instance_name"
}

variable "pi_memory" {
  type        = number
  default     = 34
  description = "vtl_pi_memory_The amount of memory that you want to assign to your instance in gigabytes"
}

variable "pi_processors" {
  type        = number
  default     = 2
  description = "vtl_pi_processors_The number of vCPUs to assign to the VM as visible within the guest Operating System"
}

variable "pi_proc_type" {
  type        = string
  default     = ""
  description = "vtl_pi_proc_type"
}

variable "pi_sys_type" {
  type        = string
  default     = ""
  description = "vtl_pi_sys_type"
}

variable "pi_storage_type" {
  type        = string
  default     = ""
  description = "vtl_pi_storage_type"
}

variable "license_repository_capacity" {
  type        = number
  default     = 1
  description = "The VTL license repository capacity in terabyte value"
}

variable "pi_network_name_1" {
  type        = string
  default     = ""
  description = "name of the 1st network"
}

variable "pi_cidr_1" {
  type        = string
  default     = ""
  description = "cidr  of the 1st network"
}

variable "pi_gateway_1" {
  type        = string
  default     = ""
  description = "gatewat  of the 1st network"
}


variable "pi_network_name_2" {
  type        = string
  default     = ""
  description = "name of the 2nd network"
}

variable "pi_cidr_2" {
  type        = string
  default     = ""
  description = "cidr  of the 2nd network"
}

variable "pi_gateway_2" {
  type        = string
  default     = ""
  description = "gatewat  of the 2st network"
}

variable "pi_network_name_3" {
  type        = string
  default     = ""
  description = "name of the 2nd network"
}

variable "pi_cidr_3" {
  type        = string
  default     = ""
  description = "cidr  of the 3rd network"
}

variable "pi_gateway_3" {
  type        = string
  default     = ""
  description = "gateway  of the 3rd network"
}


variable "placement_group" {
  type        = string
  default     = ""
  description = "The server placement group name where the VTL instance is placed, as defined for the selected Power Systems Virtual Server CRN"
}
variable "affinity_policy" {
  type        = string
  default     = ""
  description = "The policy used when determining placement of the VTL volume based on an existing PVM instance ID (or comma-separated list of IDs)"
}
variable "pvm_instances" {
  type        = string
  default     = ""
  description = "The list of PVM instance IDs to base storage anti-affinity policy against, as defined for the selected Power Systems Virtual Server CRN"
}

variable "ip_address1" {
  type        = string
  default     = ""
  description = "The second network ID or name to assign to the VTL instance, as defined for the selected Power Systems Virtual Server CRN with in the range of network CIDR"
}

variable "ip_address2" {
  type        = string
  default     = ""
  description = "The second network ID or name to assign to the VTL instance, as defined for the selected Power Systems Virtual Server CRN with in the range of network CIDR"
}

variable "ip_address3" {
  type        = string
  default     = ""
  description = "The second network ID or name to assign to the VTL instance, as defined for the selected Power Systems Virtual Server CRN with in the range of network CIDR"
}

#COS-proxy-server-details
 #sshkey details
variable "label_proxy" {
  type        = string
  default     = ""
  description = "name of the ssh key for proxy server"

}
 
variable "public_key_proxy" {
  type        = string
  default     = ""
  description = "public_ key for the ssh key"
}

 #instance details
variable "hostname-proxy" {
  type        = string
  default     = ""
  description = "proxy server hostname"
}

variable "domain-proxy" {
  type        = string
  default     = ""
  description = "proxy server domain"
}

variable "os_reference_code-proxy" {
  type        = string
  default     = ""
  description = "proxy server os_reference_code"
}

variable "datacenter-proxy" {
  type        = string
  default     = ""
  description = "proxy server datacenter"
}

variable "network_speed-proxy" {
  type        = number
  default     = 100
  description = "proxy server network_speed_The connection speed (in Mbps) for the instance's network components"
}

variable "cores-proxy" {
  type        = number
  default     = 2
  description = "proxy server cores_The number of CPU cores that you want to allocate."
}

variable "memory-proxy" {
  type        = number
  default     = 4096
  description = "proxy server memory_he amount of memory, expressed in megabytes"
}

#cloud connection details

variable "pi_cloud_connection_name" {
  type        = string
  default     = ""
  description = "cloud connetion name for connection between power and classic using gre-tunnel"
}

variable "pi_cloud_connection_speed" {
  type        = number
  default     = 500
  description = "pi_cloud_connection_speed_Speed of the cloud connection (speed in megabits per second)."
}

variable "pi_cloud_connection_gre_cidr" {
  type        = string
  default     = ""
  description = "pi_cloud_connection_gre_cidr"
}






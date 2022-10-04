variable "region" {
  type        = string
  default     = "jp-tok"
}

variable "zone" {
  type        = string
  default     = "jp-tok-4"
}

variable "ibmcloud_api_key" {
  type        = string
  default     = "OQNqQ_ViLEbciYpwVmxOQ27hkNfj0D5OBRY9kV8qx_qm"
}

variable "iaas_classic_username" {
  type        = string
  default     = "2353501_nagendra.dosapati@falconstor.com"
}

variable "iaas_classic_api_key" {
  type        = string
  default     = "68546716eb992958e804ea2a7cdc5e17e1133ddf0ebcb42044c9f5c5b0b8bfee"
}


#Vyatta router details
#ssh key details
variable "vyatta_SSHkey_name" {
  type        = string
  default     = "vyatta_SSHkey_name"
  description = "Name of the SSH key for Vyatta router"

}

variable "vyatta_public_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCGFYxD6YYwRM9VH06fmfLm1SGraxrGxBUL1kT0lewOkkrzXDCaunjLKivY/0KLFricipnswcaYF/STf0h4scy2M4QJTBemiAsisOXGHjdOdNtZaQIeH0E5t4y/d354QqdU0jZ7k26+5KfNyFw0vVjgVoYF6sHNxyGV1m3qnCN3UgCyENxXk3ffDDi4qXhll8ujj206hWXlN+/5yMUHNTP2wYjQEGJvXNL1Xr/52aWpiCx1uF/UIseWfR6l/5jGgX5/AuUzx99j1zndThcxbSJgv2Q4iO7C9+7k8ziFr7ac/BQsUReMUdi7+KWctOUky2iJLwSRhuoMHVsxttFjxTSJ rsa-key-20220922"
  description = "Vyatta router public key for SSH key creation"

}

variable "vyatta_name" {
  type        = string
  default     = "FS.DRaas.vyatta.domain"
  description = "Vyatta router name"
}

variable "vyatta_domain"{
  type        = string
  default     = "FS.DRaas.vyatta.domain"
  description = "Domain name for Vyatta router"
}

variable "vyatta_hostname" {
  type        = string
  default     = "FS.DRaas.vyatta.hostname"
  description = "Vyatta router hostname"
}


variable "vyatta_speed" {
  type        = number
  default     = 1000
  description = "Vyatta network speed in Mb/s"
}

variable "vyatta_public_bandwidth" {
  type        = number
  default     = 20000
  description = "Allowed Vyatta traffic over public network in GB/month"
}

variable "vyatta_memory" {
  type        = number
  default     = 64
  description = "Vyatta router memory amount in MB"
}

# VLAN details
variable "vlan_name" {
  type        = string
  default     = "FS_DRaas_vlan_name"
  description = "VLAN name"
}

variable "datacenter_for_classic" {
  type        = string
  default     = "tok04"
  description = "datacenter_for_classic"
}

variable "vlan_type" {
  type        = string
  default     = "PRIVATE"
  description = "VLAN type: 'PRIVATE', 'PUBLIC'"
}


# VTL tile details
variable "vtl_SSHkey_name" {
  type        = string
  default     = "vtl"
  description = "VTL SSH key name"
}

variable "vtl_public_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCTcdtPy+CkJFh2RPz3tGOF0ZPC9FUb1b1ZnwiuMN2sRDpVVtGsZC2soYMvz1YkMOpZTc+UvnUWRl3pm0XFe1udisbvyc4j/AKbCz69n6M1x5FXkxh83gURkmrdnjJvC9Dh4ScciSt05HEMYIeXJyiGh+dc0d6XHz6K7WcjdL+laOV72bCy56y9mZBzDD3/vSKdXnfhfl4i7cinWr3xMfiBE3AHkJcglTrr2E8K6OXwABXeAdk+5AECcrGMj6M1i3Gx7Sqkfd/CPYJGK4eCdIkxbgwE64+qgEr028I0fBxZ7MTm+GKuySjZA+pLwp1VggmK9GEj8ItumdGtL33F4ZY9 rsa-key-20221004"
  description = "VTL public key for SSH key creation"
}


variable "vtl_crn" {
  type        = string
  default     = "crn:v1:bluemix:public:power-iaas:tok04:a/3844b1cf5cb34837a8c414c73bb08776:d2763b70-f6dc-4828-8ac0-d133b7db3d4c::"
}

variable "vtl_instance_name" {
  type        = string
  default     = "vtl_instance"
  description = "VTL instance name"
}

variable "vtl_memory" {
  type        = number
  default     = 18
  description = " VTL memory amount in GB; it should be >= 16 + (2 * licensed_repository_capacity)"
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

variable "vtl_network_name_1" {
  type        = string
  default     = "vtl"
  description = "First network ID or name to assign to the VTL instance"
}

variable "vtl_cidr_1" {
  type        = string
  default     = "192.168.2.0/24"
  description = "First network IP addresse range"
}

variable "vtl_gateway_1" {
  type        = string
  default     = "192.168.2.1"
  description = "First network gateway IP address"
}

variable "vtl_network_name_2" {
  type        = string
  default     = ""
  description = "Second network ID or name to assign to the VTL instance"
}

variable "vtl_cidr_2" {
  type        = string
  default     = ""
  description = "Second network IP addresse range"
}

variable "vtl_gateway_2" {
  type        = string
  default     = ""
  description = "Second network gateway IP address"
}

variable "vtl_network_name_3" {
  type        = string
  default     = ""
  description = "Third network ID or name to assign to the VTL instance"
}

variable "vtl_cidr_3" {
  type        = string
  default     = ""
  description = "Third network IP addresse range"
}

variable "vtl_gateway_3" {
  type        = string
  default     = ""
  description = "Third network gateway IP address"
}

variable "vtl_placement_group" {
  type        = string
  default     = ""
  description = "Server group name where the VTL instance will be placed, as defined for the selected Power Systems Virtual Server CRN"
}
variable "vtl_affinity_policy" {
  type        = string
  default     =  "anti-affinity"
  description = "Storage anti-affinity policy to use for placemant of the VTL volume if PVM instance IDs are sepcified"
}
/*variable "vtl_pvm_instances" {
  type        = string
  default     = "faac4b76-03b4-44e1-b0b0-0f929a5a4213"
  description = "Comma-separated list of PVM instance IDs for the storage anti-affinity policy, as defined for the selected Power Systems Virtual Server CRN"
}*/

variable "vtl_ip_address_1" {
  type        = string
  default     = "192.168.2.5"
  description = "Specific IP address to assign to the first network rather than automatic assignment within the IP range"
}

variable "vtl_ip_address_2" {
  type        = string
  default     = ""
  description = "Specific IP address to assign to the second network rather than automatic assignment within the IP range"
}

variable "vtl_ip_address_3" {
  type        = string
  default     = ""
  description = "Specific IP address to assign to the third network rather than automatic assignment within the IP range"
}


# COS proxy server details
variable "proxy_SSHkey_name" {
  type        = string
  default     = "proxy"
  description = "Name of the SSH key for the proxy server"

}
 
variable "proxy_public_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCTcdtPy+CkJFh2RPz3tGOF0ZPC9FUb1b1ZnwiuMN2sRDpVVtGsZC2soYMvz1YkMOpZTc+UvnUWRl3pm0XFe1udisbvyc4j/AKbCz69n6M1x5FXkxh83gURkmrdnjJvC9Dh4ScciSt05HEMYIeXJyiGh+dc0d6XHz6K7WcjdL+laOV72bCy56y9mZBzDD3/vSKdXnfhfl4i7cinWr3xMfiBE3AHkJcglTrr2E8K6OXwABXeAdk+5AECcrGMj6M1i3Gx7Sqkfd/CPYJGK4eCdIkxbgwE64+qgEr028I0fBxZ7MTm+GKuySjZA+pLwp1VggmK9GEj8ItumdGtL33F4ZY9 rsa-key-20221004"
  description = "Proxy server public key ffor SSH key creation"
}

 #instance details
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
  description = "Proxy server network speed in Mb/s for the instance's network components"
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


# Cloud connection details
variable "cloud_connection_name" {
  type        = string
  default     = "FS_DRaaS_cloud_connection"
  description = "The name of the Power direct link to Classic using Generic Routing Encapsulation (GRE) tunnel"
}

variable "cloud_connection_speed" {
  type        = number
  default     = 500
  description = "Cloud connection speed in Mb/s"
}

variable "cloud_connection_gre_cidr" {
  type        = string
  default     = "172.20.0.1/29"
  description = "Range of IP addresses for GRE as Classless Inter-Domain Routing (CIDR)"
}

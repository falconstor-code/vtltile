variable "label" {
  type        = string
  default     = "hcecikey1-vyatta"
  description = "ssh_ci_details_map"

}

variable "public_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCR/RibYgjL++oaT67N+tn/QLP+cX8lNvL4JlYHpZ2xJjEzjRH64qDoDszxM//8Oa9jtdWtkJR9p0Uzb4LIxb6jnPWw4/iTBuiAc56awSl2SiWYgAHOa5NU6cPU9VbveQUMKOkJxtaqE+GzZHEzJzc69IOmv4BLeEatiuv6HOIE2fAbsj9go7uTiM5ShboevdkLo5/Cf53fiV+9gWgGAkM4CU77yfsmJ5CEHXo4rApz6/jrqkXyIJQbQpqhsxbkIZeA1XBgH4DolTKCZno7BHaXN8fK/eYTN6Ox2lwYLvYMf2tm5SSo8DLCY/IxOPpUdZd9nPc1yBooi1sEtICcixE7 rsa-key-20220908"
  description = "ssh_ci_details_map"

}

variable "vyatta_details" {
default = {
    name= "my-gateway-hce"
    hostname= "host-name-hce"
    datacenter= "tok04"
    network_speed= 1000
    public_bandwidth= 20000
    memory= 64
    ssh_ci_key= "hcecikey1-vyatta"
  }

  type = object(
    {
        name= string,
        hostname= string,
        datacenter= string,
        network_speed= number,
        public_bandwidth= number,
        memory= number,
        ssh_ci_key= string
   }
      )
} 

variable "vlan_details" {
default = {
        name= "Hce_vlan"
        datacenter= "tok04"
        type= "PUBLIC"
        vyatta_gateway_name= "my-gateway-hce"
  }

  type = object(
    {
        name= string,
        datacenter= string,
        type= string,
        vyatta_gateway_name= string
   }
      )
}

variable "crn" {
  type        = string
  default     = "crn:v1:bluemix:public:power-iaas:tok04:a/3844b1cf5cb34837a8c414c73bb08776:d2763b70-f6dc-4828-8ac0-d133b7db3d4c::"
  description = "Power Systems Virtual Server CRN"
}

variable "VTL_details" {
default = {
        pi_instance_name= "vtl_draas"
        pi_memory = 34
        pi_processors = 2
        pi_proc_type = "shared"
        pi_sys_type = "s922"
        pi_storage_type = "tier1"
        pi_key_name ="vtlterrformkey1"
  }

  type = object(
    {
        pi_instance_name= string,
        pi_memory =number,
        pi_processors =number,
        pi_proc_type =string,
        pi_sys_type =string,
        pi_storage_type =string,
        pi_key_name =string,
   }
      )
}

variable "ssh_pi_details" {
default = {
        pi_ssh_key= "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDV8Euqw4zK9zgVtZSXcUz9iC9CY7hBrAAV7G5Yg0ZJ6bI2Yo4ttvOaTAoDiJomjTaf7MenI7Cepoc1iiCwgjYOx2GE9PseIk0fFk1/k9eurjG/5oeNPT4N9p2lC8z0s0lLZaOW1YJJ4yqyV4xkPygQ3VxVfWL/iM71986Lx2/pb+DNZJxPP65O0VqeGLcKO12yMwEYGwoM0/ZeaivMj+IOEn5BBPlwIqq2g0RNcF2E4v1jSGEvMkndM8BZLwKjtUFrWeZem2uUlY3vR7PYjlMYFpWERV58HfzeMTBVjwQnW110i72JDuBAd6jqKF2i83skcxIWjiXdHVxBjKuNkB19 rsa-key-20220830"
        pi_key_name= "vtlterrformkey1"
}

  type = object(
    {
        pi_ssh_key= string,
        pi_key_name= string
   }
      )
}

variable "license_repository_capacity" {
  type        = number
  default     = 1
  description = "The VTL license repository capacity in terabyte value"
}

variable "networks" {
default = {
      network_1 = "vtl-network1"
      network_2 = ""
      network_3 = ""
  }

  type = object(
    {
      network_1 =string,
      network_2 =string,
      network_3 =string
   }
      )
}

variable "pi_network_1_details" {
default = {
      pi_network_name= "vtl-network1"
      pi_cidr= "192.168.1.0/24"
      pi_gateway= "192.168.1.1"
  }

  type = object(
    {
      pi_network_name= string
      pi_cidr= string,
      pi_gateway= string,
   }
      )
}

variable "pi_network_2_details" {
default = {
      pi_network_name= ""
      pi_cidr= ""
      pi_gateway= ""
  }

  type = object(
    {
      pi_network_name= string
      pi_cidr= string,
      pi_gateway= string,
   }
      )
}

variable "pi_network_3_details" {
default = {
      pi_network_name= ""
      pi_cidr= ""
      pi_gateway= ""
  }

  type = object(
    {
      pi_network_name= string
      pi_cidr= string,
      pi_gateway= string,
   }
      )
}

variable "placement_group" {
  type        = string
  default     = ""
  description = "The server placement group name where the VTL instance is placed, as defined for the selected Power Systems Virtual Server CRN"
}
variable "affinity_policy" {
  type        = string
  default     = "anti-affinity"
  description = "The policy used when determining placement of the VTL volume based on an existing PVM instance ID (or comma-separated list of IDs)"
}
variable "pvm_instances" {
  type        = string
  default     = ""
  description = "The list of PVM instance IDs to base storage anti-affinity policy against, as defined for the selected Power Systems Virtual Server CRN"
}

variable "ip_address1" {
  type        = string
  default     = "192.168.100.19"
  description = "The second network ID or name to assign to the VTL instance, as defined for the selected Power Systems Virtual Server CRN"
}

variable "ip_address2" {
  type        = string
  default     = "192.168.100.19"
  description = "The second network ID or name to assign to the VTL instance, as defined for the selected Power Systems Virtual Server CRN"
}

variable "ip_address3" {
  type        = string
  default     = "192.168.100.19"
  description = "The second network ID or name to assign to the VTL instance, as defined for the selected Power Systems Virtual Server CRN"
}



variable "ssh_ci_details" {
default = {
        public_key= "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtb8ako1vAzHL8MndaMhZp8uGSxobq02VGrb66GCO+AuRUaOsjqUmJy1+hGk3kHmVIiaJNqlS97TnJ1npvjMNhB+U5Fv+esYXfctVFUxvVxHVpjh6kNMzrgbn7fHxo679d1KNZnyFF7wJuU3VoH/AIKjQ+4ltoKZgM3aeC4u+0be+jvvTQKiCRXmr4HyUZR+z7IQClO4LuywRjPcLgDZjpXi0LAC9Nopfozh0jKWKU9t6mHBE1jchldtGUXyAV3qy/EgYXBRvgk0gW0axdCiZ3YLe4kXRscq3JOObLP3GeJa08amItOcpdeD7n1n9Ln2BYmL946s0sTjnJh9QN10NH rsa-key-20220913"
        label= "proxy2"
}

  type = object(
    {
        public_key= string,
        label= string
   }
      )
}

variable "proxy_server_details" {
default = {
      hostname="cos.nginx.proxy_1"
      domain= "FalconStor.cloud" 
      os_reference_code= "CENTOS_7_64", 
      datacenter= "tok04", 
      network_speed= 100
      cores= 2 
      memory= 4096 
      ssh_key_name= "proxy2"
  }

  type = object(
    {
      hostname= string,
      domain= string, 
      os_reference_code= string, 
      datacenter= string, 
      network_speed= number,
      cores= number, 
      memory= number, 
      ssh_key_name= string,
   }
      )
}

variable "cloud_connection_details" {
default = {
        pi_cloud_connection_name= "hce-connection"
        pi_cloud_instance_id= "d2763b70-f6dc-4828-8ac0-d133b7db3d4c" 
        pi_cloud_connection_speed= 1000 
        pi_cloud_connection_gre_cidr= "172.20.0.0/29"
        vyatta_gateway_name=  "my-gateway-hce"
  }

  type = object(
    {
        pi_cloud_connection_name= string,
        pi_cloud_instance_id= string, 
        pi_cloud_connection_speed= number, 
        pi_cloud_connection_gre_cidr= string,
        vyatta_gateway_name= string,
   }
      )
}





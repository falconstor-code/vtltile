output "private_ip_vyatta" {
  description = "The ID of the vpc"
  value = ibm_network_gateway.gateway.private_ipv4_address
}

output "public_ip_vyatta" {
  description = "The ID of the vpc"
  value =ibm_network_gateway.gateway.public_ipv4_address
}

output "subnets_of_vyatta" {
  description = "The ID of the vpc"
  value = ibm_network_vlan.test_vlan.subnets 
}

output "pi_network_1_cidr" {
  description = "The ID of the vpc"
  value = ibm_pi_network.power_network_1.pi_cidr
}

output "pi_network_1_gateway" {
  description = "The ID of the vpc"
  value = ibm_pi_network.power_network_1.pi_gateway 
}

output "members" {
  description = "The ID of the vpc"
  value = ibm_network_gateway.gateway.members 
}


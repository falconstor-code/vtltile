output "pi_network_1_cidr" {
  description = "The ID of the vpc"
  value = ibm_pi_network.power_network_1.pi_cidr
}

output "pi_network_1_gateway" {
  description = "The ID of the vpc"
  value = ibm_pi_network.power_network_1.pi_gateway 
}



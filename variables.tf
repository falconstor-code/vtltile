variable "crn" {
  type        = string
  default     = ""
  description = "Power Systems Virtual Server CRN"
}
variable "license_repository_capacity" {
  type        = number
  default     = 1
  description = "The VTL licensed repository capacity in TB"
}
variable "memory" {
  type        = number
  default     = 18
  description = "The amount of memory to assign to the VTL in GB according to the following formula: memory >= 16 + (2 * license_repository_capacity)"
}
variable "processors" {
  type        = number
  default     = 2
  description = "The number of vCPUs, AKA virtual processors, to assign to the VTL virtual machine instance; one vCPU is equal to one physical CPU core."
}
variable "instance_name" {
  type        = string
  default     = ""
  description = "The name to assign to the VTL instance"
}
variable "processor_type" {
  type        = string
  default     = "shared"
  description = "The type of processor mode in which the VTL will run: 'shared', 'capped', or 'dedicated'"
}
variable "sys_type" {
  type        = string
  default     = "s922"
  description = "The type of system on which to create the VTL: 's922', 'e980'"
}
variable "storage_type" {
  type        = string
  default     = "tier1"
  description = "The type of storage tier for used volumes: 'tier1' (high performance) or 'tier3'"
}
variable "ssh_key_name" {
  type        = string
  default     = ""
  description = "The name of the public SSH RSA key to access the VTL instance, as defined for the selected Power Systems Virtual Server CRN"
}
variable "network_1" {
  type        = string
  default     = ""
  description = "The first network ID or name to assign to the VTL instance, as defined for the selected Power Systems Virtual Server CRN"
}
variable "network_1_ip" {
  type        = string
  default     = ""
  description = "Specific IP address to assign to the first network rather than automatic assignment within the IP range"
}
variable "network_2" {
  type        = string
  default     = ""
  description = "The second network ID or name to assign to the VTL instance, as defined for the selected Power Systems Virtual Server CRN"
}
variable "network_2_ip" {
  type        = string
  default     = ""
  description = "Specific IP address to assign to the second network rather than automatic assignment within the IP range"
}
variable "network_3" {
  type        = string
  default     = ""
  description = "The third network ID or name to assign to the VTL instance, as defined for the selected Power Systems Virtual Server CRN"
}
variable "network_3_ip" {
  type        = string
  default     = ""
  description = "Specific IP address to assign to the third network rather than automatic assignment within the IP range"
}
variable "placement_group" {
  type        = string
  default     = ""
  description = "The server placement group name where the VTL instance will be placed, as defined for the selected Power Systems Virtual Server CRN"
}
variable "affinity_policy" {
  type        = string
  default     = "anti-affinity"
  description = "The storage anti-affinity policy to use for placemant of the VTL volume if PVM instance IDs are sepcified"
}
variable "pvm_instances" {
  type        = string
  default     = ""
  description = "The comma-separated list of PVM instance IDs for the storage anti-affinity policy, as defined for the selected Power Systems Virtual Server CRN"
}

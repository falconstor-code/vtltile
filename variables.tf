variable "crn" {
  type        = string
  default     = ""
  description = "Power Systems Virtual Server CRN"
}
variable "repository_capacity" {
  type        = number
  default     = 1
  description = "StorSafe VTL repository capacity in TB"
}
variable "memory" {
  type        = number
  default     = 18
  description = "Amount of memory to assign to StorSafe VTL in GB according to the following formula: memory >= 16 + (2 * repository_capacity)"
}
variable "vcpus" {
  type        = number
  default     = 1
  description = "The number of vCPUs, AKA virtual processors, to assign to StorSafe VTL; one vCPU is equal to one physical CPU core."
}
variable "instance_name" {
  type        = string
  default     = ""
  description = "The name to assign to the StorSafe VTL instance"
}
variable "processor_type" {
  type        = string
  default     = "shared"
  description = "Processor mode in which the StorSafe VTL instance will run: 'shared', 'capped', or 'dedicated'"
}
variable "system_type" {
  type        = string
  default     = "s922"
  description = "Type of system on which to create the StorSafe VTL instance: 's922', 'e980'"
}
variable "storage_type" {
  type        = string
  default     = "tier1"
  description = "The type of storage tier for StorSafe VTL volumes: 'tier1' (high performance) or 'tier3'"
}
variable "ssh_key_name" {
  type        = string
  default     = ""
  description = "Name of the public SSH RSA key to access StorSafe VTL, as defined for the selected Power Systems Virtual Server CRN"
}
variable "network_1" {
  type        = string
  default     = ""
  description = "First network ID or name to assign to StorSafe VTL, as defined for the selected Power Systems Virtual Server CRN"
}
variable "network_1_ip" {
  type        = string
  default     = ""
  description = "Specific IP address to assign to the first network rather than automatic assignment within the IP range"
}
variable "network_2" {
  type        = string
  default     = ""
  description = "Second network ID or name to assign to StorSafe VTL, as defined for the selected Power Systems Virtual Server CRN"
}
variable "network_2_ip" {
  type        = string
  default     = ""
  description = "Specific IP address to assign to the second network rather than automatic assignment within the IP range"
}
variable "network_3" {
  type        = string
  default     = ""
  description = "Third network ID or name to assign to StorSafe VTL, as defined for the selected Power Systems Virtual Server CRN"
}
variable "network_3_ip" {
  type        = string
  default     = ""
  description = "Specific IP address to assign to the third network rather than automatic assignment within the IP range"
}
variable "placement_group" {
  type        = string
  default     = ""
  description = "Server placement group name where the StorSafe VTL instance will be placed, as defined for the selected Power Systems Virtual Server CRN"
}
variable "policy_affinity" {
  type        = string
  default     = "anti-affinity"
  description = "Storage anti-affinity policy to use for placemant of the StorSafe VTL instance volume if PVM instance IDs are sepcified"
}
variable "pvm_anti_affinity" {
  type        = string
  default     = ""
  description = "Comma-separated list of other Power Virtual Server (PVM) instance IDs to apply the storage anti-affinity policy for placemant of the StorSafe VTL instance volume, as defined for the selected Power Systems Virtual Server CRN"
}
variable "volume_configuration_size" {
  type        = number
  default     = 20
  description = "Size of the block storage volume for the StorSafe VTL Configuration Repository in GB"
}
variable "volume_index_size" {
  type        = number
  default     = 1024
  description = "Size of the block storage volume for the index of StorSafe VTL Deduplication Repository in GB; the maximum size of a volume is 2 TB; attach extra volumes later, if necessary"
}
variable "volume_tape_size" {
  type        = number
  default     = 1024
  description = "Size of the block storage volume for the StorSafe VTL tape backup cache in GB; the maximum size of a volume is 2 TB; attach extra volumes later, if necessary"
}

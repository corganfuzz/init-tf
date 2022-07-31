variable "location" {
  type        = string
  description = "Azure Region"
  default     = "eastus2"
}

variable "network-vnet-cidr" {
  type        = string
  default     = "172.16.0.0/16"
  description = "The CIDR for the network VNET"
}

variable "vm-subnet-cidr" {
  type        = string
  default     = "172.16.0.0/24"
  description = "The CIDR for the vm subnet"
}

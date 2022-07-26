variable "location" {
  type        = string
  description = "Azure Region"
  default     = "eastus2"
}

variable "network-vnet-cidr" {
  type        = string
  description = "The CIDR for the vm subnet"
}

variable "vm-subnet-cidr" {
  type        = string
  description = "The CIDR for the vm subnet"
}

variable "nginx_vm_size" {
  type        = string
  description = "Size SKU of VM"
  default     = "Standard_B1s"
}

variable "nginx_admin_username" {
  type        = string
  description = "VM Username"
  default     = "admin"
}

variable "nginx_admin_password" {
  description = "VM admin password"
  type        = string
  default     = ""
}

variable "nginx-publisher" {
  type        = string
  description = "NGINX Publisher ID"
  default     = "nginxinc"
}

variable "nginx-plus-offer" {
  type        = string
  description = "NGINX Offer ID"
  default     = "nginx-plus-v1"
}


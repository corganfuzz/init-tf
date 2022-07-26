# Main Resource Group

resource "azurerm_resource_group" "network-gr" {
  name     = "nginx-network-gr"
  location = var.location
}

# Create a VNET

resource "azurerm_virtual_network" "network-vnet" {
  name                = "nginx-network-vnet"
  address_space       = [var.network-vnet-cidr]
  resource_group_name = azurerm_resource_group.network-gr.name
  location            = azurerm_resource_group.network-gr.location
}

# Create a Sbnet for VM

resource "azurerm_subnet" "vm-subnet" {
  name                 = "nginx-vm-subnet"
  address_prefixes     = [var.vm-subnet-cidr]
  virtual_network_name = azurerm_resource_group.network-vnet.name
  resource_group_name  = azurerm_resource_group.network-gr.name
}


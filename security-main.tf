# Security Group Creation

resource "azurerm_network_security_group" "nginx-vm-nsg" {
  depends_on = [azurerm_resource_group.network-gr]

  name                = "nginxvm-nsg"
  location            = azurerm_resource_group.network-gr.location
  resource_group_name = azurerm_resource_group.network-gr.name

  # Allows inbound SSH from entire internet

  security_rule {
    name                       = "Allow-SSH"
    description                = "Allow SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP"
    description                = "Allow HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

# Associate the web NSG with the subnet

resource "azurerm_subnet_network_security_group_association" "ngx-nsg-assoc" {
  depends_on = [
    azurerm_resource_group.network-gr
  ]

  subnet_id                 = azurerm_subnet.vm-subnet.id
  network_security_group_id = azurerm_network_security_group.nginx-vm-nsg.id
}

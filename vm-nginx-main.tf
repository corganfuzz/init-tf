# Bootstrap template bash file

data "template_file" "nginx-vm-cloud-init" {
  template = file("install-nginx.sh")
}


# Gen a random password

resource "random_password" "nginx-vm-password" {
  length           = 16
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  numeric          = true
  special          = true
  override_special = "!@#$%&"
}

# Gen a random vm name

resource "random_string" "nginx-vm-name" {
  length  = 8
  upper   = false
  numeric = false
  lower   = true
  special = false
}

# Request and assign a public ip address and nic

# Get an static public IP

resource "azurerm_public_ip" "nginx-vm-ip" {
  depends_on = [azurerm_resource_group.network-gr]

  name                = "nginx-${random_string.nginx-vm-name.result}-ip"
  location            = azurerm_resource_group.network-gr.location
  resource_group_name = azurerm_resource_group.network-gr.name
  allocation_method   = "Static"
}

# Create a NIC for this VM

resource "azurerm_network_interface" "nginx-nic" {
  depends_on = [
    azurerm_resource_group.network-gr
  ]

  name                = "nginx-${random_string.nginx-vm-name.result}-nic"
  location            = azurerm_resource_group.network-gr.location
  resource_group_name = azurerm_resource_group.network-gr.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.nginx-vm-ip.id
  }
}

# Create the definition for the NGINX VM

resource "azurerm_linux_virtual_machine" "nginx-vm" {
  depends_on = [azurerm_network_interface.nginx-nic]

  name                  = "nginx-${random_string.nginx-vm-name.result}-vm"
  location              = azurerm_resource_group.network-gr.location
  resource_group_name   = azurerm_resource_group.network-gr.name
  network_interface_ids = [azurerm_network_interface.nginx-nic.id]
  size                  = var.nginx_vm_size

  source_image_reference {
    publisher = var.nginx-publisher
    offer     = var.nginx-plus-offer
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  # plan {
  #   name      = "nginx-plus-ubuntu1804"
  #   publisher = var.nginx-publisher
  #   product   = var.nginx-plus-offer
  # }

  os_disk {
    name                 = "nginx-${random_string.nginx-vm-name.result}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  computer_name  = "nginx-${random_string.nginx-vm-name.result}-vm"
  admin_username = var.nginx_admin_username
  admin_password = random_password.nginx-vm-password.result
  custom_data    = base64encode(data.template_file.nginx-vm-cloud-init.rendered)

  disable_password_authentication = false


}


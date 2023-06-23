provider "azurerm" {
  features {}
}

data "azurerm_virtual_network" "example" {
  name                = var.network_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "example" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.example.name
}


resource "azurerm_public_ip" "example" {
  name                = "public-ip-KG"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Basic"
  sku_tier            = "Regional"
}

resource "azurerm_network_interface" "example" {
  name                = "nicKG"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = data.azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id           = azurerm_public_ip.example.id
  }
}

resource "tls_private_key" "ssh_key" {
  algorithm   = "RSA"
  rsa_bits    = 4096
}

resource "azurerm_virtual_machine" "example" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = var.vm_size

  storage_os_disk {
    name              = "osdiskKG"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = var.os_offer
    sku       = var.os_sku
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = ""
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = tls_private_key.ssh_key.public_key_openssh
    }
  }
}

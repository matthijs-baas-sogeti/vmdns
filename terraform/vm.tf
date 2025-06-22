resource "azurerm_public_ip" "pipDNS" {
  name                = "vm-public-ip"
  location            = azurerm_resource_group.rgDNS.location
  resource_group_name = azurerm_resource_group.rgDNS.name
  allocation_method   = "Static"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "nicDNS" {
  name                = "vm-nic"
  location            = azurerm_resource_group.rgDNS.location
  resource_group_name = azurerm_resource_group.rgDNS.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetDNS.id
    private_ip_address_allocation = "Static"
    public_ip_address_id          = azurerm_public_ip.pipDNS.id
  }
}

resource "azurerm_linux_virtual_machine" "vmDNS" {
  name                = "ubuntu-vm"
  resource_group_name = azurerm_resource_group.rgDNS.name
  location            = azurerm_resource_group.rgDNS.location
  size                = "Standard_B2s"
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.nicDNS.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "ubuntu-os-disk"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "vmDNS"
  disable_password_authentication = true

}

resource "null_resource" "run_remote_script" {
  depends_on = [azurerm_linux_virtual_machine.vmDNS]

  connection {
    type        = "ssh"
    host        = azurerm_public_ip.pipDNS.ip_address
    user        = var.admin_username
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "file" {
    source      = "${path.module}/init-script.sh"
    destination = "/home/${var.admin_username}/init-script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/${var.admin_username}/init-script.sh",
      "sudo /home/${var.admin_username}/init-script.sh"
    ]
  }
}

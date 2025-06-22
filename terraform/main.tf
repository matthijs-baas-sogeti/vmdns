resource "azurerm_resource_group" "rgDNS" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnetDNS" {
  name                = "vnetDNS"
  resource_group_name = azurerm_resource_group.rgDNS.name
  location            = azurerm_resource_group.rgDNS.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnetDNS" {
  name                 = "subnetDNS"
  resource_group_name  = azurerm_resource_group.rgDNS.name
  virtual_network_name = azurerm_virtual_network.vnetDNS.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create NSG with a rule to allow inbound traffic ( for ssh testing purposes )
resource "azurerm_network_security_group" "nsgDNS" {
  name                = "nsgDNS"
  location            = azurerm_resource_group.rgDNS.location
  resource_group_name = azurerm_resource_group.rgDNS.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
  security_rule {
    name                       = "AllowAdguardGUI"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "*" 
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Allow-DNS-TCP-UDP"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "53"
    source_address_prefix      = "*" 
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "assDNS" {
  subnet_id                 = azurerm_subnet.subnetDNS.id
  network_security_group_id = azurerm_network_security_group.nsgDNS.id
}

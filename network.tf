resource "azurerm_resource_group" "example" {
  name     = var.rg_name
  location = var.region
}

resource "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
 address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "control-vm" {
  name                 = "c-vm_subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefix       = "10.0.0.0/24"
}

resource "azurerm_subnet" "webserver" {
  name                 = "websubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_network_interface" "control-vm" {
  name                = "control-vm_nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.control-vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.control-vm.id
  }
}  


resource "azurerm_network_interface" "webserver" {
  name                = "webserver_nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.webserver.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.webserver.id
  }
}


resource "azurerm_public_ip" "control-vm" {
  name                = "control-vm_pip"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
  sku                 = "Standard"
}


output "public_ip" {
  value = [azurerm_public_ip.control-vm.ip_address]
}


resource "azurerm_public_ip" "webserver" {
  name                = "web_pip"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
  sku                 = "Standard"
}


resource "azurerm_subnet" "db" {
  name                 = "dbsubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_network_interface" "db" {
  name                = "db_nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.db.id
    private_ip_address_allocation = "Dynamic"
  }
}  










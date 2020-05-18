variable "rg_name" {
  default = "ansible"
  description = "used for resource group's name"
}


variable "region" {
  default = "centralus"
  description = "location where resource group and resources are created"
}


variable "vnet_name" {
    default = "ansible-vnet"
}

variable "vnet_cidr" {
    default = ["10.0.0.0/16"]
}

variable "vm_size" {
    default = "Standard_B2s"
}

variable "vm_username" {
    default = "adminuser"
}

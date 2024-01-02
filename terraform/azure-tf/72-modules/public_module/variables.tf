# variable tags
variable "ex_tags" {
    description = "tags to use through out the exercise"
    type = string
    default = "dev"
}

# Resource Group Name
variable "resoure_group_name" {
  description = "Resource Group Name"
  type = string
  default = "myrg1"
}
# Resource Group Location
variable "resoure_group_location" {
  description = "Resource Group Location"
  type = string
  default = "westeurope"
}

# Virtual Network Name
variable "virtual_network_name" {
  description = "Virtual Network Name"
  type        = string
  default     = "myvnet"
}

# Virtual network Address space
variable "vnet_address_space" {
    description = "Virtual network address space"
    type = list(string)
    default = ["10.0.0.0/16"]
}

# Subnet Name: Assign When Prompted using CLI
variable "subnet_name" {
  description = "Virtual Network Subnet Name"
  type        = string
  # default = mysubnet
}

variable "modulesubnet_name" {
  description = "Virtual Network Subnet Name"
  type        = list(string)
  default = ["mysubnet"]
}

# Subnet prefix
variable "subnet_add_prefix" {
    description = "Subnet address prefix"
    type = list(string)
    default = ["10.0.2.0/24"]
}

# Public IP SKU
variable "public_ip_sku" {
  description = "Azure Public IP Address SKU"
  type = map(string)
  default = {
    "westeurope" = "Basic"
    "eastus" = "Standard" 
  }
}

# Security group name
variable "security_group_name" {
  description = "security group name"
  type = string
  default = "myNetworkSecurityGroup"
}

# SSH security rule 
variable "ssh_security_rule" {
  description = "ssh security rule type define"
  type = object({
    name = string
    priority = number
    direction = string
    access = string
    protocol = string
    destination_port_range = number
  })
}

# HTTP Security rule
variable "http_security_rule" {
  description = "http security rule type define"
  type = tuple([string, number, string, string, string, number])
}

# # VM Variables

# # VM name
# variable "vm_name" {
#   description = "Virtual Machine name"
#   type = string
#   default = "slazsasltest01"
# }

# #Computer name
# variable "computer_name" {
#   description = "Virtual Machine name"
#   type = string
#   default = "devlinux-vm1"
# }

# # Size of the VM
# variable "vm_size" {
#   description = "Virtual Machine name"
#   type = string
#   default = "Standard_B1s"
# }

# # Admin User name
# variable "user_name" {
#   description = "Virtual Machine name"
#   type = string
#   default = "azureuser"
# }

# # disk and image reference
# variable "disk_image_reference" {
#   description = "image and disk"
#   type = list(string)
#   default = ["osdisk", "ReadWrite", "Standard_LRS", "Canonical", "0001-com-ubuntu-server-jammy", "22_04-lts-gen2", "latest"]
# }
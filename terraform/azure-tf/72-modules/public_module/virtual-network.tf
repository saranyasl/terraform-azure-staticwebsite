# # Create Virtual Network
# resource "azurerm_virtual_network" "myvnet" {
#   name                = var.virtual_network_name
#   address_space       = var.vnet_address_space
#   #address_space      = ["10.0.0.0/16"]
#   #address_space       = [var.virtual_network_address_space[0]]
#   location            = azurerm_resource_group.myrg.location
#   resource_group_name = local.rg_name
# }

# # Create Subnet
# resource "azurerm_subnet" "mysubnet" {
#   name                 = var.subnet_name
#   resource_group_name  = local.rg_name
#   virtual_network_name = azurerm_virtual_network.myvnet.name
#   address_prefixes     = var.subnet_add_prefix
# }


module "vnetmodule" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"
  vnet_location = var.resoure_group_location
  vnet_name = var.virtual_network_name
  resource_group_name = local.rg_name
  use_for_each = false
  address_space       = var.vnet_address_space
  subnet_prefixes     = var.subnet_add_prefix
  subnet_names = var.modulesubnet_name
  depends_on = [azurerm_resource_group.myrg]
}

# Create Public IP Address
resource "azurerm_public_ip" "mypublicip" {
  name                = "mypublicip-1"
  resource_group_name = local.rg_name
  location            = azurerm_resource_group.myrg.location
  allocation_method   = "Static"
  domain_name_label = "app1-vm"
  sku = lookup(var.public_ip_sku, var.resoure_group_location)
  # domain_name_label = "app1-vm-${random_string.myrandom.id}"
  tags = {
    environment = var.ex_tags
  }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "mynsg" {
  name                = var.security_group_name
  location            = azurerm_resource_group.myrg.location
  resource_group_name = local.rg_name
  security_rule {
    name                       = var.ssh_security_rule.name
    priority                   = var.ssh_security_rule.priority
    direction                  = var.ssh_security_rule.direction
    access                     = var.ssh_security_rule.access
    protocol                   = var.ssh_security_rule.protocol
    source_port_range          = "*"
    destination_port_range     = var.ssh_security_rule.destination_port_range
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = var.http_security_rule[0]
    priority                   = var.http_security_rule[1]
    direction                  = var.http_security_rule[2]
    access                     = var.http_security_rule[3]
    protocol                   = var.http_security_rule[4]
    source_port_range          = "*"
    destination_port_range     = var.http_security_rule[5]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create Network Interface
resource "azurerm_network_interface" "myvmnic" {
  name                = "vmnic"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = local.rg_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnetmodule.vnet_subnets[0]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.mypublicip.id 
  }
  tags = {
    environment = var.ex_tags
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsgassociation" {
  network_interface_id      = azurerm_network_interface.myvmnic.id
  network_security_group_id = azurerm_network_security_group.mynsg.id
}
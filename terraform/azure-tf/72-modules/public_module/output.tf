# 1. Output Values - Resource Group
output "resource_group_id" {
  description = "Resource Group ID"
  # Atrribute Reference
  value = azurerm_resource_group.myrg.id 
}
output "resource_group_name" {
  description = "Resource Group name"
  # Argument Reference
  value = azurerm_resource_group.myrg.name  
}

output "resource_group_location" {
  description = "Resource Group Location"
  # Argument Reference
  value = azurerm_resource_group.myrg.location  
}


# 2. Output Values - Virtual Network
output "virtual_network_name" {
  description = "Virutal Network Name"
  value = module.vnetmodule.vnet_name
  #sensitive = true
}

# 3. Output Values - Network Interface
output "network_interface_id" {
  description = "Azure Network Interface ID"
  value = module.vnetmodule.vnet_id
}
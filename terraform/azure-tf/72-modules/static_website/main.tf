# Provider Block
provider "azurerm" {
 features {}          
}

# Random String Resource
# resource "random_string" "myrandom" {
#   length = 6
#   upper = false 
#   special = false
#   numeric = false   
# }

# Create Resource Group
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

# Create Azure Storage account
resource "azurerm_storage_account" "storage_account" {
  name                = var.storage_account_name
  resource_group_name = azurerm_resource_group.resource_group.name
 
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind
  
  static_website {
    index_document = var.static_website_index_document
    error_404_document = var.static_website_error_404_document
  }
}

resource "azurerm_storage_blob" "index" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "${var.static_website_source_folder}/index.html"
}

resource "azurerm_storage_blob" "error" {
  name                   = "error.html"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "${var.static_website_source_folder}/error.html"
}

resource "azurerm_storage_container" "example" {
  name                  = "sample"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "sample" {
  name                   = "error.html"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  content_type           = "text/html"
  source                 = "${var.static_website_source_folder}/error.html"
}
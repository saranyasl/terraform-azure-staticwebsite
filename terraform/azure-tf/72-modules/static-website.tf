# Call our Custom Terraform Module which we built earlier
# module "azure_static_website" {
#   source = "./modules/azure-static-website" # Mandatory

#   # Resource Group
#   location                          = "westeurope"
#   resource_group_name               = "myrg1"

#   # Storage Account
#   storage_account_name              = "staticwebsite"
#   storage_account_tier              = "Standard"
#   storage_account_replication_type  = "LRS"
#   storage_account_kind              = "StorageV2"
#   static_website_index_document     = "index.html"
#   static_website_error_404_document = "error.html"  
# }

module "azure_static_website" {
  # source = "./modules/azure-static-website"
  source  = "saranyasl/staticwebsite/azure"
  version = "1.0.0"
  location = "westeurope"
  resource_group_name = "myrg1"
  storage_account_name = "staticwebsitesasl1"
  storage_account_tier = "Standard"
  storage_account_replication_type  = "LRS"
  storage_account_kind              = "StorageV2"
  static_website_index_document     = "index.html"
  static_website_error_404_document = "error.html"  
}
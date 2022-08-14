provider "azurerm" {
  features {}
}

# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#     }
#   }
# }

terraform {
  backend "azurerm" {
    resource_group_name = "eastTwo"
    storage_account_name = "storagetfx"
    container_name = "containertfx"
    key = "terraform.tfstate"
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~>3.0"
    }
  }

  #   backend "azurerm" {
  #     subscription_id      = ""
  #     resource_group_name  = ""
  #     storage_account_name = ""
  #     container_name       = "tfstate"
  #     key                  = "terraform.tfstate"
  #   }

}

provider "azurerm" {
  features {}
  subscription_id = ""
}

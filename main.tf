terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "project-plato-rg" {
  name     = "${var.project}-${var.environment}"
  location = var.location
}

resource "azurerm_container_registry" "project-plato-container-regsitry" {
  name                = "${var.project}${var.environment}registry"
  resource_group_name = azurerm_resource_group.project-plato-rg.name
  location            = var.location
  sku                 = "Basic"
}

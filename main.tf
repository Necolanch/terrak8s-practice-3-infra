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

locals {
  registry_project = lower(replace(var.project, "-", ""))
}

resource "azurerm_resource_group" "terrak8s-practice-3-rg" {
  name     = "${var.project}-${var.environment}"
  location = var.location
}

resource "azurerm_container_registry" "terrak8s-practice-3-container-regsitry" {
  name                = "${local.registry_project}${var.environment}registry"
  resource_group_name = azurerm_resource_group.terrak8s-practice-3-rg.name
  location            = var.location
  sku                 = "Basic"
}

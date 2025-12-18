terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.55.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscriptionId
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

# App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = "${var.project}-plan"
  resource_group_name = azurerm_resource_group.terrak8s-practice-3-rg.name
  location            = azurerm_resource_group.terrak8s-practice-3-rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

# Application Insights
resource "azurerm_application_insights" "appinsights" {
  name                = "${var.project}-logs"
  location            = azurerm_resource_group.terrak8s-practice-3-rg.location
  resource_group_name = azurerm_resource_group.terrak8s-practice-3-rg.name
  application_type    = "web"
}

# Web App
resource "azurerm_linux_web_app" "app" {
  name                = "${var.project}-app"
  resource_group_name = azurerm_resource_group.terrak8s-practice-3-rg.name
  location            = azurerm_resource_group.terrak8s-practice-3-rg.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      node_version = "22-lts"
    }
    always_on = "false"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.appinsights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.appinsights.connection_string
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE"   = "false"
  }

  identity {
    type = "SystemAssigned"
  }
}
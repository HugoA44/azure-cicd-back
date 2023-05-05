terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.54.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "7c212f64-7f85-4084-90f4-616e52220bb5"
  tenant_id       = "8a2f18a9-8f0e-4f76-a585-9b07b3a38dea"
}

resource "azurerm_resource_group" "example" {
  name     = "hugo-rg"
  location = "France Central"
}

resource "azurerm_service_plan" "example" {
  name                = "hugo-super-plan-service"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "example" {

  name                = "hugo-super-back"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_service_plan.example.location
  service_plan_id     = azurerm_service_plan.example.id
  site_config {
    always_on = false
  }
}

resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id                 = azurerm_linux_web_app.example.id
  repo_url               = "https://github.com/HugoA44/azure-cicd-back"
  branch                 = "master"
  use_manual_integration = true
  use_mercurial          = false
}


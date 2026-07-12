resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_service_plan" "plan" {

  name = "nodejs-app-service-plan"

  location = "southindia"

  resource_group_name = azurerm_resource_group.rg.name

  os_type = "Linux"

  sku_name = "B1"
}


resource "azurerm_cosmosdb_account" "cosmos" {
  name = "nodecosmosmongo12345"

  location = "eastus2"

  resource_group_name = azurerm_resource_group.rg.name


  offer_type = "Standard"


  kind   = "MongoDB"

  capabilities {
    name = "EnableMongo"
  }


  consistency_policy {

    consistency_level = "Session"

  }


  geo_location {

    location = "eastus2"

    failover_priority = 0
    zone_redundant    = false

  }

}


resource "azurerm_cosmosdb_mongo_database" "database" {

  name = "todolist"

  resource_group_name = azurerm_resource_group.rg.name

  account_name = azurerm_cosmosdb_account.cosmos.name

}


resource "azurerm_linux_web_app" "app" {

  name = var.app_name

  location = "southindia"

  resource_group_name = azurerm_resource_group.rg.name

  service_plan_id = azurerm_service_plan.plan.id
  https_only      = true

  site_config {

    application_stack {

      node_version = "20-lts"

    }

  }


  app_settings = {

    "AZURE_COSMOS_CONNECTIONSTRING" = azurerm_cosmosdb_account.cosmos.primary_mongodb_connection_string

  }

}
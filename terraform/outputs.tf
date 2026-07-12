output "webapp_url" {

  value = azurerm_linux_web_app.app.default_hostname

}


output "cosmos_connection" {

  value = azurerm_cosmosdb_account.cosmos.primary_mongodb_connection_string

  sensitive = true

}
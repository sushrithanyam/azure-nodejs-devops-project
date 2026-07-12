variable "location" {
  description = "Azure region"
  default     = "Canada Central"
}

variable "resource_group_name" {
  description = "Resource group name"
  default     = "rg-nodejs-mongodb-devops"
}

variable "app_name" {
  description = "Azure Web App name"
}

variable "cosmos_account_name" {
  description = "Cosmos DB account name"
}
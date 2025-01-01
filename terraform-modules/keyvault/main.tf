provider "azurerm" {
  features {}
}

data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault 
  resource_group_name = var.resourcegroup 
}

resource "azurerm_role_assignment" "secret_reader_role" {
  for_each = var.bot_configurations

  principal_id       = each.value.ad_group_objectid  # Get Object ID of the AD group
  role_definition_name = "Key Vault Reader"  # Assign the Secret Reader role
  scope              = data.azurerm_key_vault.keyvault.id  # Assign to the entire Key Vault
}

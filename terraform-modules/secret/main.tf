provider "azurerm" {
  features {}
}

# Fetch keyvault details by keyvaut names
data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault                 # Use each Key Vault name
  resource_group_name = var.resourcegroup   # Provide the resource group name where the Key Vaults exist
}

resource "azurerm_key_vault_secret" "secret" {
  for_each = var.bot_configurations

  name         = "secret-${var.foldername}-${each.value.botname}"
  value        =  "123"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}


resource "azurerm_role_assignment" "secret_officer_role" {
  for_each = var.bot_configurations

  # Assign the Secret Officer role to the Azure AD group for each secret
  principal_id       = each.value.ad_group_objectid
  role_definition_name = "Key Vault Secrets Officer"  # Secret Officer role grants create, update, and delete permissions on secrets
  scope              = "${data.azurerm_key_vault.keyvault.id}/secrets/${azurerm_key_vault_secret.secret[each.key].name}"  # Assign to specific secret

  depends_on = [azurerm_key_vault_secret.secret]
}

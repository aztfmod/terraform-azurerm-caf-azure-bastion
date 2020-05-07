output "object" {
  depends_on = [azurerm_bastion_host.azurebastion]
  value = azurerm_bastion_host.azurebastion
}

output "name" {
  depends_on = [azurerm_bastion_host.azurebastion]
  value = azurerm_bastion_host.azurebastion.*.name
}

output "id" {
  depends_on = [azurerm_bastion_host.azurebastion]
  value = azurerm_bastion_host.azurebastion.*.id
}
resource "azurerm_bastion_host" "azurebastion" {
  name                = var.bastion_config.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                 = "bastionpipconfiguration"
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_address_id
  }
}
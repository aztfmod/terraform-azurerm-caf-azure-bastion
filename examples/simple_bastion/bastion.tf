provider "azurerm" {
   features {}
}

resource "azurerm_resource_group" "rg_test" {
  name     = local.resource_groups.test.name
  location = local.resource_groups.test.location
  tags     = local.tags
}

module "la_test" {
  source  = "aztfmod/caf-log-analytics/azurerm"
  version = "2.0.1"
 
  convention          = local.convention
  location            = local.location
  name                = local.name_la
  solution_plan_map   = local.solution_plan_map 
  prefix              = local.prefix
  resource_group_name = azurerm_resource_group.rg_test.name
  tags                = local.tags
}

module "diags_test" {
  source  = "aztfmod/caf-diagnostics-logging/azurerm"
  version = "2.0.1"
 
  name                  = local.name_diags
  convention            = local.convention
  resource_group_name   = azurerm_resource_group.rg_test.name
  prefix                = local.prefix
  location              = local.location
  tags                  = local.tags
  enable_event_hub      = local.enable_event_hub
}

module "vnet_test" {
  source  = "aztfmod/caf-virtual-network/azurerm"
  version = "2.0.0"
    
  convention                        = local.convention
  resource_group_name               = azurerm_resource_group.rg_test.name
  prefix                            = local.prefix
  location                          = local.location
  networking_object                 = local.vnet_config
  tags                              = local.tags
  diagnostics_map                   = module.diags_test.diagnostics_map
  log_analytics_workspace           = module.la_test
  diagnostics_settings              = local.vnet_config.diagnostics
}

module "bastion_pip" {
  source  = "aztfmod/caf-public-ip/azurerm"
  version = "2.0.0"

  convention                       = local.convention
  name                             = local.ip_addr_config.ip_name
  location                         = local.location
  resource_group_name              = azurerm_resource_group.rg_test.name
  ip_addr                          = local.ip_addr_config
  tags                             = local.tags
  diagnostics_map                  = module.diags_test.diagnostics_map
  log_analytics_workspace_id       = module.la_test.id
  diagnostics_settings             = local.ip_addr_config.diagnostics
}

module "bastion" {
  source = "../../"

  bastion_config                   = local.bastion_config
  
  name                             = local.bastion_config.name
  resource_group_name              = azurerm_resource_group.rg_test.name
  subnet_id                        = lookup(module.vnet_test.vnet_subnets, "AzureBastionSubnet", null)
  public_ip_address_id             = module.bastion_pip.id
  location                         = local.location
  tags                             = local.tags
  
  convention                       = local.convention 
  diagnostics_map                  = module.diags_test.diagnostics_map
  log_analytics_workspace          = module.la_test.object
  diagnostics_settings             = local.bastion_config.diagnostics

}

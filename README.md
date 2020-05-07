[![Gitter](https://badges.gitter.im/aztfmod/community.svg)](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

# Configures an Azure Bastion

Configures an Azure Bastion environment. 

Reference the module to a specific version (recommended):
```hcl
module "azure_bastion" {
    source  = "aztfmod/azure_bastion/azurerm"
    version = "0.x.y"
    
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
```

## Inputs 

| Name | Type | Default | Description |
| -- | -- | -- | -- |
| enable_bastion | bool | True | (Optional) Determine to deploy Bastion for the configuration. |
| subnet_id | string | None | (Required) Subnet ID to plug Azure Bastion. |
| public_ip_address_id | string | None | (Required) ID of hte Public IP address to use. |
| bastion_config | object | None |(Required) Bastion configuration object. | 
| resource_group_name | string | None | (Required) Name of the resource group where to create the resource. Changing this forces a new resource to be created. |
| name | string | None | (Required) Name for the objects created (before naming convention applied.) |
| location | string | None | (Required) Specifies the Azure location to deploy the resource. Changing this forces a new resource to be created.  |
| tags | map | None | (Required) Map of tags for the deployment.  |
| convention | string | None | (Required) Naming convention to be used (check at the naming convention module for possible values).  |
| prefix | string | None | (Optional) Prefix to be used. |
| postfix | string | None | (Optional) Postfix to be used. |
| max_length | string | None | (Optional) maximum length to the name of the resource. |
| log_analytics_workspace | string | None | Log Analytics Workspace. | 
| diagnostics_map | map | None | Map with the diagnostics repository information.  | 
| diagnostics_settings | object | None | Map with the diagnostics settings. See the required structure in the following example or in the diagnostics module documentation. | 

## Parameters

### bastion_config

(Required) The configuration object describing the Azure Bastion configuration
Mandatory properties are:
- name
- diagnostics

Properties of the IP_addr block are the same as describe in the IP configuration module [here](https://github.com/aztfmod/terraform-azurerm-caf-public-ip/blob/master/README.md)

```hcl
bastion_config = {
        name = "azurebastion"
        diagnostics = {
            log = [
                #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
                ["BastionAuditLogs", true, true, 30],
            ]
            metric = [
                #    ["AllMetrics", true, true, 30],
            ]
        }
    }
```

## Outputs

| Name | Type | Description | 
| -- | -- | -- | 
| id | map | Returns the id of the bastion configuration |
| name | map | Returns the name of the bastion configuration |
| object | map | Returns the object of the bastion configuration |
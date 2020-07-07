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

<!--- BEGIN_TF_DOCS --->
<!--- END_TF_DOCS --->

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
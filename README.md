# **READ ME**

Thanks for your interest in Cloud Adoption Framework for Azure landing zones on Terraform.
This module is now deprecated and no longer maintained. 

As part of Cloud Adoption Framework landing zones for Terraform, we have migrated to a single module model, which you can find here: https://github.com/aztfmod/terraform-azurerm-caf and on the Terraform registry: https://registry.terraform.io/modules/aztfmod/caf/azurerm 

In Terraform 0.13 you can now call directly submodules easily with the following syntax:
```hcl
module "caf_firewall" {
  source  = "aztfmod/caf/azurerm//modules/networking/firewall"
  version = "0.4.18"
  # insert the 9 required variables here
}
```

[![VScodespaces](https://img.shields.io/endpoint?url=https%3A%2F%2Faka.ms%2Fvso-badge)](https://online.visualstudio.com/environments/new?name=terraform-azurerm-azure-bastion&repo=aztfmod/terraform-azurerm-azure-bastion)
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
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bastion\_config | (Required) Bastion configuration object | `any` | n/a | yes |
| convention | (Required) Naming convention method to use | `any` | n/a | yes |
| diagnostics\_map | (Required) contains the SA and EH details for operations diagnostics | `any` | n/a | yes |
| diagnostics\_settings | (Required) configuration object describing the diagnostics | `any` | n/a | yes |
| location | (Required) Specifies the Azure location to deploy the resource. Changing this forces a new resource to be created. | `any` | n/a | yes |
| log\_analytics\_workspace | (Required) contains the log analytics workspace details for operations diagnostics | `any` | n/a | yes |
| max\_length | (Optional) You can speficy a maximum length to the name of the resource | `string` | `""` | no |
| name | (Required) Name for the objects created (before naming convention applied.) | `any` | n/a | yes |
| postfix | (Optional) You can use a postfix to the name of the resource | `string` | `""` | no |
| prefix | (Optional) You can use a prefix to the name of the resource | `string` | `""` | no |
| public\_ip\_address\_id | (Required) ID of the Public IP address to use. | `any` | n/a | yes |
| resource\_group\_name | (Required) Name of the resource group where to create the resource. Changing this forces a new resource to be created. | `any` | n/a | yes |
| subnet\_id | (Required) Subnet ID to plug Azure Bastion. | `any` | n/a | yes |
| tags | (Required) Map of tags for the deployment. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| name | n/a |
| object | n/a |

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

# When Terraform will have condition module support, link it back to https://github.com/aztfmod/terraform-azurerm-caf-diagnostics

resource "azurerm_monitor_diagnostic_setting" "diagnostics" {
  count = var.enable_bastion ? 1 : 0

  name                             = "${azurerm_bastion_host.azurebastion.0.name}-diag"
  target_resource_id               = azurerm_bastion_host.azurebastion.0.id
  
  eventhub_name                    = lookup(var.diagnostics_map, "eh_name", null)
  eventhub_authorization_rule_id   = lookup(var.diagnostics_map, "eh_id", null) != null ? "${var.diagnostics_map.eh_id}/authorizationrules/RootManageSharedAccessKey" : null
  
  log_analytics_workspace_id       = var.log_analytics_workspace.id
  log_analytics_destination_type   = lookup(var.bastion_config.diagnostics, "log_analytics_destination_type", null)

  storage_account_id               = var.diagnostics_map.diags_sa
  
  dynamic "log" {
      for_each = var.bastion_config.diagnostics.log
      content {
          category    = log.value[0]
          enabled =     log.value[1]
          retention_policy {
              enabled =     log.value[2]
              days    = log.value[3]
          }
      }
  }   

  dynamic "metric" {
      for_each = var.bastion_config.diagnostics.metric
      content {
          category    = metric.value[0]
          enabled =     metric.value[1]
          retention_policy {
              enabled =     metric.value[2]
              days    = metric.value[3]
          }
          }
  }
  }  
locals {
    convention = "cafrandom"
    name = "caftest-vnet"
    name_la = "caftestlavalid"
    name_diags = "caftestdiags"
    location = "southeastasia"
    prefix = ""
    enable_event_hub = false
    resource_groups = {
        test = { 
            name     = "test-caf-bastion"
            location = "southeastasia" 
        },
    }
    tags = {
        environment     = "DEV"
        owner           = "CAF"
    }
    solution_plan_map = {
        NetworkMonitoring = {
            "publisher" = "Microsoft"
            "product"   = "OMSGallery/NetworkMonitoring"
        },
    }

    name_ddos = "test_ddos"

    vnet_config = {
        vnet = {
            name                = "TestVnet"
            address_space       = ["10.0.0.0/16"]     
        }
        specialsubnets = { 
        }
        subnets = {
            subnet1                 = {
                name                = "AzureBastionSubnet" #Must be called AzureBastionSubnet 
                cidr                = "10.0.0.128/25"
                nsg_inbound         = [
                    ["bastion-in-allow", "100", "Inbound", "Allow", "tcp", "*", "443", "*", "*"],
                    ["bastion-control-in-allow-443", "120", "Inbound", "Allow", "tcp", "*", "443", "GatewayManager", "*"],
                    ["bastion-control-in-allow-4443", "121", "Inbound", "Allow", "tcp", "*", "4443", "GatewayManager", "*"],
                ]
                nsg_outbound        = [
                    ["bastion-vnet-out-allow-22", "100", "Outbound", "Allow", "tcp", "*", "22", "*", "VirtualNetwork"],
                    ["bastion-vnet-out-allow-3389", "101", "Outbound", "Allow", "tcp", "*", "3389", "*", "VirtualNetwork"],
                    ["bastion-azure-out-allow", "120", "Outbound", "Allow", "tcp", "*", "443", "*", "AzureCloud"],
                ]
            }
        }
        diagnostics = {
            log = [
                    # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
                    ["VMProtectionAlerts", true, true, 60],
            ]
            metric = [
                    #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]                 
                    ["AllMetrics", true, true, 60],
            ]   
        }
    }

    ip_addr_config = {
        ip_name = "arnaud-egress"    
        allocation_method   = "Static"
        #Dynamic Public IP Addresses aren't allocated until they're assigned to a resource (such as a Virtual Machine or a Load Balancer) by design within Azure 
        
        #properties below are optional 
        sku                 = "Standard"                        #defaults to Basic
        ip_version          = "IPv4"                            #defaults to IP4, Only dynamic for IPv6, Supported arguments are IPv4 or IPv6, NOT Both

        diagnostics = {
            log = [
                        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
                        ["DDoSProtectionNotifications", true, true, 30],
                        ["DDoSMitigationFlowLogs", true, true, 30],
                        ["DDoSMitigationReports", true, true, 30],
                ]
            metric = [
                    ["AllMetrics", true, true, 30],
            ]
        }
    }

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

}
#Create Virtual Network

resource "azurerm_network_security_group" "RemotelyNSG" {
    name = "RemotelyNSG_${var.environment}"
    location = azurerm_resource_group.RemotelyRG.location
    resource_group_name = azurerm_resource_group.RemotelyRG.name
}
resource "azurerm_virtual_network" "RemotelyVNet" {
    name = "RemotelyVNet_${var.environment}"
    location = azurerm_resource_group.RemotelyRG.location
    resource_group_name = azurerm_resource_group.RemotelyRG.name
    address_space       = ["10.0.0.0/16"]
    tags = {
        environment= "${var.environment}"
    }
}

#Create appservice plan

resource "azurerm_app_service_plan" "RemotelyASP" {
  count = 2 
  name                = "remotelyasp_${var.environment}_${count.index}"
  location            = azurerm_resource_group.RemotelyRG.location
  resource_group_name = azurerm_resource_group.RemotelyRG.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

#Create app services 3 for azurerm_app_service_plan.RemotelyASP[0] and 1 for azurerm_app_service_plan.RemotelyASP[1]

#resource "azurerm_app_service" "RemotelyASs" {
  #  count = 3
  #  name = "RemotelyAS_${var.environment}_${count.index}"
   # location = azurerm_resource_group.RemotelyRG.location
  #  resource_group_name = azurerm_resource_group.RemotelyRG.name
   # app_service_plan_id = 

    #site_config {
      
  #  }
   # }
  
#}

output "CDNEndpoint" {
    value = "azurerm_cdn_endpoint.RemotelyCDNEndpoint.host_name"
}

output "ASP_ID_1" {
    value = "azurerm_app_service_plan.RemotelyASP[00].id"
}

output "ASP_ID_2" {
    value = "azurerm_app_service_plan.RemotelyASP[01].id"
}
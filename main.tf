resource "azurerm_virtual_network_gateway" "vpn" {
  for_each                      = local.vpn
  name                          = each.value.name
  resource_group_name           = var.resource_group_output[each.value.resource_group_name].name
  location                      = var.resource_group_output[each.value.resource_group_name].location
  type                          = each.value.type
  vpn_type                      = each.value.vpn_type
  active_active                 = each.value.active_active
  enable_bgp                    = each.value.enable_bgp
  sku                           = each.value.sku
  generation                    = each.value.generation
  edge_zone                     = each.value.edge_zone
  private_ip_address_enabled    = each.value.private_ip_address_enabled
  tags                          = each.value.tags
  dynamic "bgp_settings" {
    for_each = each.value.enable_bgp == false ? [] : each.value.bgp_settings
    content {
      asn                   = bgp_settings.value.asn
      peer_weight           = bgp_settings.value.peer_weight
      dynamic "peering_addresses" {
       for_each = each.value.active_active == true ? [] : bgp_settings.value.peering_addresses
       content {
         ip_configuration_name = peering_addresses.value.ip_configuration_name
         apipa_addresses       = peering_addresses.value.apipa_addresses
       } 
      }
    }   
  }

  dynamic "ip_configuration" {
   for_each =  each.value.ip_configuration
   content {
     name = ip_configuration.value.name
     #private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
     subnet_id = var.subnet_output[format("%s/%s", ip_configuration.value.virtual_network_name, ip_configuration.value.subnet_name)].id
     public_ip_address_id = var.public_ip_output[ip_configuration.value.public_ip_name].id
   }
  }
}
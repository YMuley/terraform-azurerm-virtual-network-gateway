locals {
   vpn = {for vpn in var.vpn_list : vpn.name => vpn}
}
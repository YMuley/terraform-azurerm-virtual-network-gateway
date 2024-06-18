locals {
   vpn = {for vpn in var.var.vpn_list : vpn.name => vpn}
}
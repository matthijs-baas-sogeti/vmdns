output "PiP" {
  value = "Admin page is (with fresh install) at: http://${azurerm_public_ip.pipDNS.ip_address}:3000"
}

output "warning" {
  value = "Note: use this locally: ssh -i ~/.ssh/id_rsa -L 3000:127.0.0.1:3000 vmdns_admin@${azurerm_public_ip.pipDNS.ip_address} and connect in local browser"
}

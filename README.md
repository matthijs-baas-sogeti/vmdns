# VM AdguardDNS

This will create a VM in Azure using Terraform which configures Ubuntu and installs AdGuardHome.

It will create a public IP which you can use as your DNS. ( See picture below )
This will filter your internet traffic to deny ad serving websites and known malicious websites
using several blocklists including [OISD](https://oisd.nl/)

<img src="https://www.magnify247.com/wp-content/uploads/sites/346/2020/02/mag4.png" width="300"/>

---

# Video Adguard dashboard
<a href="https://cdn.adguard.com/public/Adguard/Blog/AGHome/dashboard.mp4" target="_blank">
  <img src="https://cdn.adguard.com/public/Adguard/Blog/AGHome/dashboard.jpg" width="300"/>
</a>

---

## 🚀 Features

- Ubuntu 22.04
- AdGuardHome

---

## 📦 Installation

```bash
# Run powershell terminal as Administrator

# Set your desired DNS server IP
$primaryDNS = "<PublicIP-VM>"

# Set the name of the network adapter (e.g., "Ethernet", "Wi-Fi")
$adapterName = "Ethernet"

# Apply the DNS setting to the adapter
Set-DnsClientServerAddress -InterfaceAlias $adapterName -ServerAddresses $primaryDNS

# Confirm the change
Get-DnsClientServerAddress -InterfaceAlias $adapterName

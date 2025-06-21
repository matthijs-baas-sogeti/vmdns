# VM AdguardDNS

This will create a VM which configures Ubuntu and installs AdGuardHome.
It will add a public IP which you can use to point your local DNS to,
this will filter your internet traffic to deny ad serving websites and known malicious websites.

[![Dashboard Preview](https://cdn.adguard.com/public/Adguard/Blog/AGHome/dashboard.jpg)](https://cdn.adguard.com/public/Adguard/Blog/AGHome/dashboard.mp4)


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

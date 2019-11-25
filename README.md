# WireGuard Wrapper
Simple wrapper that makes WireGuard easier to use with VPN providers.

### Table of Contents
1. [Prerequisites](https://github.com/adihrustic/WireGuard-Wrapper#prerequisites)
1. [Installation](https://github.com/adihrustic/WireGuard-Wrapper#installation)
1. [Usage](https://github.com/adihrustic/WireGuard-Wrapper#usage)
    1. [Connecting](https://github.com/adihrustic/WireGuard-Wrapper#connecting-to-a-server)
    1. [Disconnecting](https://github.com/adihrustic/WireGuard-Wrapper#disconnecting-from-a-server)
    1. [Kill-switch configuration](https://github.com/adihrustic/WireGuard-Wrapper#enablingdisabling-kill-switch)
    1. [Listing servers](https://github.com/adihrustic/WireGuard-Wrapper#listing-servers)
    1. [Connection status](https://github.com/adihrustic/WireGuard-Wrapper#status-of-current-connection)
    1. [Choosing start-up server](https://github.com/adihrustic/WireGuard-Wrapper#choosing-start-up-server)
    1. [Updating server list](https://github.com/adihrustic/WireGuard-Wrapper#updating-the-server-list)
    1. [Updating default server](https://github.com/adihrustic/WireGuard-Wrapper#updating-default-server)
1. [Troubleshooting](https://github.com/adihrustic/WireGuard-Wrapper#troubleshooting-and-FAQ)
1. [More Information](https://github.com/adihrustic/WireGuard-Wrapper#more-information)
1. [Authors](https://github.com/adihrustic/WireGuard-Wrapper#authors)
1. [License](https://github.com/adihrustic/WireGuard-Wrapper#license)


## Prerequisites
VPN providers who are offering WireGuard support. **NOTE** that as of right now, these providers **must** offer a configuration script following the original template written by Jason A. Donenfeld. To my knowledge the current VPN providers doing this are:
* [Mullvad](https://mullvad.net/)
* [AzireVPN](https://www.azirevpn.com/)

```
sudo add-apt-repository ppa:wireguard/wireguard && sudo apt-get update;
sudo apt-get install curl jq openresolv linux-headers-$(uname -r) wireguard-dkms wireguard-tools
```

## Installation
Simply run the following commands in your terminal and follow the instructions
```
cd ./WireGuard-Wrapper/;
sudo ./setup.sh install
```

## Usage
### Connecting to a server
```
wvpn connect <server>
```

It is also possible to leave out server specification and connect to the default server that was set during the installation:
```
wvpn connect
```

### Disconnecting from a server
```
wvpn disconnect
```

### Enabling/Disabling kill-switch
```
wvpn kill-switch <on|off> <server>
```

It is also possible to pass multiple servers as arguments, or even all of them. To enable a kill-switch for all servers run:
```
wvpn kill-switch <on|off> all
```

### Listing servers
When updating the server list you will be shown the current available servers. To access the list again run:
```
wvpn list
```

### Status of current connection
To get more detailed information about your connection, run
```
wvpn status
```

### Choosing start-up server
It is possible to choose a server that will auto connect on boot.
```
wvpn start-up <on|off> <server>
```

### Updating the server list
```
sudo wvpn update servers
```

### Updating default server
```
wvpn update default <server>
```
This command will let you change the default server set during the installation. Use the `list` command to view the current default.


### Verify connection
Verification of a connection will be done every time a connection tries to be established, To manually check the verification run:
```
wvpn verify
```

### Help
```
wvpn help
```

## Troubleshooting and FAQ
### Connection down when resuming after sleep or hibernation
This is likely due to the network manager not using openresolv. [See here for a possible solution.](https://wiki.archlinux.org/index.php/NetworkManager#Use_openresolv)
### Unable to remotely access local machines.
Enabling the kill switch blocks all local traffic. Either add iptable rules to circumvent this or disable the kill switch.
### Was this previously the wrapper only intended for the mullvad VPN?
Yes. However, I chose to implement a more general solution.

## More information
* [Running WireGuard with Mullvad on Linux](https://mullvad.net/en/guides/wireguard-and-mullvad-vpn) - Mullvad's official guide.
* [Running WireGuard with AzireVPN on Linux](https://www.azirevpn.com/support/guides/computer/linux/wireguard-cli) - AzireVPN's official guide.
* [WireGuard](https://www.wireguard.com/) - Official WireGuard website.

## Authors
Adi Hrustic

## License
This project is licensed under the GNU General Public License v3.0 - see the [LICENSE.md](LICENSE.md) file for details.

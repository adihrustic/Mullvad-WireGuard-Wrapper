# Mullvad WireGuard script
Simple script that makes it easier to use Mullvad's VPN with WireGuard.

### Table of Contents
1. [Prerequisites](https://github.com/adihrustic/Mullvad-WireGuard-script#prerequisites)
1. [Installation](https://github.com/adihrustic/Mullvad-WireGuard-script#installation)
1. [Usage](https://github.com/adihrustic/Mullvad-WireGuard-script#usage)
    1. [Connecting](https://github.com/adihrustic/Mullvad-WireGuard-script#connecting-to-a-server)
    1. [Updating default server](https://github.com/adihrustic/Mullvad-WireGuard-script#updating-default-server)
    1. [Disconnecting](https://github.com/adihrustic/Mullvad-WireGuard-script#disconnecting-from-a-server)
    1. [Kill-switch configuration](https://github.com/adihrustic/Mullvad-WireGuard-script#enablingdisabling-kill-switch)
    1. [Listing servers](https://github.com/adihrustic/Mullvad-WireGuard-script#listing-servers)
    1. [Connection status](https://github.com/adihrustic/Mullvad-WireGuard-script#status-of-current-connection)
    1. [Verifying Connection](https://github.com/adihrustic/Mullvad-WireGuard-script#verifying-connection)
1. [More Information](https://github.com/adihrustic/Mullvad-WireGuard-script#more-information)
1. [Authors](https://github.com/adihrustic/Mullvad-WireGuard-script#authors)
1. [License](https://github.com/adihrustic/Mullvad-WireGuard-script#license)

## Prerequisites
* [Mullvad Account](https://mullvad.net/)
* WireGuard
```
sudo add-apt-repository ppa:wireguard/wireguard && sudo apt-get update && sudo apt-get install wireguard
```

## Installation
Simply run the following command in your terminal
```
sudo make install
```

You then need to update the server list before you can connect to a server
```
mullvad update servers
```

This will download the config file from Mullvad's website and run it. You will be prompted to enter your account number.

## Usage
### Connecting to a server
To connect to a server, simply write
```
mullvad connect <server>
```

It it also possible to leave out server selection and connect to default
```
mullvad connect
```

Note that this needs to be set with `mullvad update default`, before using the above command.

### Disconnecting from a server
```
mullvad disconnect
```

### Updating default server
```
mullvad update default
```
This command will let you set a default server of your choosing. Useful and practical.

### Enabling/Disabling kill-switch
Enable a kill-switch
```
mullvad kill-switch-on <server>
```

Disable the kill-switch
```
mullvad kill-switch-off <server>
```

It is possible to choose multiple servers. To enable a kill-switch for all servers run
```
mullvad kill-switch-on all
```

### Listing servers
When you first update the server list you will shown the current available servers. To view the list again type
```
mullvad list
```

The current available servers are
```
au1:  Sydney, Australia
ca1:  Toronto, Canada
ch1:  Zurich, Switzerland
de1:  Frankfurt, Germany
de2:  Frankfurt, Germany
fr1:  Paris, France
gb1:  London, UK
gb2:  London, UK
hk1:  Hong Kong, Hong Kong
nl1:  Amsterdam, Netherland
no1:  Oslo, Norway
pl1:  Warsaw, Poland
se1:  Malmö, Sweden
se2:  Stockholm, Sweden
us1:  New York, USA
us2:  Los Angeles, USA
us3:  Miami, USA
us4:  Chicago, USA
us5:  Seattle, USA
```

### Status of current connection
To get more detailed information about your connection, run
```
mullvad status
```

### Verifying connection
To verify connection, run
```
mullvad verify
```

### Help
The help section can be accessed with
```
mullvad help
```

## More information
* [Running WireGuard with Mullvad on Linux](https://mullvad.net/en/guides/wireguard-and-mullvad-vpn/) - Mullvad's official guide.
* [WireGuard](https://www.wireguard.com/) - Official WireGuard website.

## Authors
Adi Hrustic

## License
This project is licensed under the GNU General Public License v3.0 - see the [LICENSE.md](LICENSE.md) file for details.

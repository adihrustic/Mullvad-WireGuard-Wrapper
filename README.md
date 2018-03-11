# Mullvad WireGuard script
Simple script that makes it easier to use Mullvad's VPN with WireGuard.

## Prerequisites
* [Mullvad Account](https://mullvad.net/)
* WireGuard
```
sudo add-apt-repository ppa:wireguard/wireguard && sudo apt-get update && 
sudo apt-get install curl linux-headers-$(uname -r) wireguard-dkms wireguard-tools
```

## Installation
Simply run the following command in your terminal
```
sudo make install
```

You then need to update the server list before you can connect to a server
```
mullvad update
```

This will download the config file from Mullvad's website and run it. You will be prompted to enter your account number.

## Usage
### Connecting to a server
To connect to a server, simply write
```
mullvad connect <server>
```

It it also possible to leave out server selection and only write
```
mullvad connect
```

Note that this is currently set to **se1** Malmö, Sweden.

### Disconnecting from a server
```
mullvad disconnect
```

### Enabling/Disabling kill-switch
Enable a kill-switch
```
mullvad kill-switch-on <server>
```

It is possible to choose multiple servers. To enable a kill-switch for all servers run
```
mullvad kill-switch-on all
```

Disable the kill-switch
```
mullvad kill-switch-off <server>
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
fr1:  Paris, France
gb1:  London, UK
hk1:  Hong Kong, Hong Kong
nl1:  Amsterdam, Netherland
no1:  Oslo, Norway
se1:  Malmö, Sweden
se2:  Stockholm, Sweden
us1:  New York, USA
us2:  Los Angeles, USA
us3:  Miami, USA
us4:  Chicago, USA
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



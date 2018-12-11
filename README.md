# [#Project moved to GitLab#](https://gitlab.com/adihrustic/Mullvad-WireGuard-Wrapper)
## Follow the above link or use the script file to fetch the project.

------------------------
# Mullvad WireGuard Wrapper  <img src="https://slethen.io/content/images/2017/01/mullvad-logo.png" align="left" width="40" height="40" alt="logo">
Simple wrapper that makes it easier to use Mullvad's VPN with WireGuard.

<img src="https://i.imgur.com/QqBj2Rm.gif" align="right" alt="gif" width="515" height="412">

### Table of Contents
1. [Prerequisites](https://github.com/adihrustic/Mullvad-WireGuard-Wrapper#prerequisites)
1. [Installation](https://github.com/adihrustic/Mullvad-WireGuard-Wrapper#installation)
1. [Usage](https://github.com/adihrustic/Mullvad-WireGuard-Wrapper#usage)
    1. [Connecting](https://github.com/adihrustic/Mullvad-WireGuard-Wrapper#connecting-to-a-server)
    1. [Updating default server](https://github.com/adihrustic/Mullvad-WireGuard-sWrapper#updating-default-server)
    1. [Disconnecting](https://github.com/adihrustic/Mullvad-WireGuard-Wrapper#disconnecting-from-a-server)
    1. [Kill-switch configuration](https://github.com/adihrustic/Mullvad-WireGuard-Wrapper#enablingdisabling-kill-switch)
    1. [Listing servers](https://github.com/adihrustic/Mullvad-WireGuard-Wrapper#listing-servers)
    1. [Connection status](https://github.com/adihrustic/Mullvad-WireGuard-Wrapper#status-of-current-connection)
    1. [Choosing start-up server](https://github.com/adihrustic/Mullvad-WireGuard-Wrapper#choosing-start-up-server)
1. [Troubleshooting](https://github.com/adihrustic/Mullvad-WireGuard-Wrapper#troubleshooting)
1. [More Information](https://github.com/adihrustic/Mullvad-WireGuard-Wrapper#more-information)
1. [Authors](https://github.com/adihrustic/Mullvad-WireGuard-Wrapper#authors)
1. [License](https://github.com/adihrustic/Mullvad-WireGuard-Wrapper#license)


## Prerequisites
* [Mullvad Account](https://mullvad.net/)
* WireGuard

```
sudo add-apt-repository ppa:wireguard/wireguard && sudo apt-get update;
sudo apt-get install curl jq openresolv linux-headers-$(uname -r) wireguard-dkms wireguard-tools
```

## Installation
Simply run the following command in your terminal
```
sudo make install
```
Before connecting you will need to use to update command to refresh the server list

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
mullvad update default <server>
```
This command will let you set a default server of your choosing. Use the `list` command to view the current default.

### Enabling/Disabling kill-switch
Enable a kill-switch
```
mullvad kill-switch on <server>
```

Disable a kill-switch
```
mullvad kill-switch off <server>
```

It is possible to choose multiple servers. To enable a kill-switch for all servers run
```
mullvad kill-switch <on|off> all
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
ch2:  Zurich, Switzerland
de1:  Frankfurt, Germany
de2:  Frankfurt, Germany
de3:  Berlin, Germany
dk1:  Copenhagen, Denmark
es1:  Madrid, Spain
fi1:  Helsinki, Finland
fr1:  Paris, France
gb1:  London, UK
gb2:  London, UK
hk1:  Hong Kong, Hong Kong
nl1:  Amsterdam, Netherlands
no1:  Oslo, Norway
pl1:  Warsaw, Poland
ro1:  Bucharest, Romania
se1:  Malmö, Sweden
se2:  Stockholm, Sweden
se3:  Gothenburg, Sweden
se4:  Malmö, Sweden
sg1:  Singapore, Singapore
us1:  New York, NY, USA
us2:  Los Angeles, CA, USA
us3:  Miami, FL, USA
us4:  Chicago, IL, USA
us5:  Seattle, WA, USA
us6:  Atlanta, GA, USA
us7:  Dallas, TX, USA
```

### Status of current connection
To get more detailed information about your connection, run
```
mullvad status
```

### Choosing start-up server
It is possible to choose a server that will auto connect on boot.
```
mullvad start-up <on|off> <server>
```

### Help
The help section can be accessed with
```
mullvad help
```

## Troubleshooting
### Connection down when resuming after sleep or hibernation
This is likely due to the network manager not using openresolv. [See here for a possible solution.](https://wiki.archlinux.org/index.php/NetworkManager#Use_openresolv)

## More information
* [Running WireGuard with Mullvad on Linux](https://mullvad.net/en/guides/wireguard-and-mullvad-vpn/) - Mullvad's official guide.
* [WireGuard](https://www.wireguard.com/) - Official WireGuard website.

## Authors
Adi Hrustic

## License
This project is licensed under the GNU General Public License v3.0 - see the [LICENSE.md](LICENSE.md) file for details.

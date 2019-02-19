# [#Project moved to GitLab#](https://gitlab.com/adihrustic/Mullvad-WireGuard-Wrapper)
## Follow the above link or use the script file to fetch the project.
------------------------
# Mullvad WireGuard Wrapper  <img src="https://slethen.io/content/images/2017/01/mullvad-logo.png" align="left" width="40" height="40" alt="logo">
Simple wrapper that makes it easier to use Mullvad's VPN with WireGuard.

<img src="https://i.imgur.com/QqBj2Rm.gif" align="right" alt="gif" width="515" height="412">

### Table of Contents
1. [Prerequisites](https://gitlab.com/adihrustic/Mullvad-WireGuard-Wrapper#prerequisites)
1. [Installation](https://gitlab.com/adihrustic/Mullvad-WireGuard-Wrapper#installation)
1. [Usage](https://gitlab.com/adihrustic/Mullvad-WireGuard-Wrapper#usage)
    1. [Connecting](https://gitlab.com/adihrustic/Mullvad-WireGuard-Wrapper#connecting-to-a-server)
    1. [Updating default server](https://gitlab.com/adihrustic/Mullvad-WireGuard-Wrapper#updating-default-server)
    1. [Disconnecting](https://gitlab.com/adihrustic/Mullvad-WireGuard-Wrapper#disconnecting-from-a-server)
    1. [Kill-switch configuration](https://gitlab.com/adihrustic/Mullvad-WireGuard-Wrapper#enablingdisabling-kill-switch)
    1. [Listing servers](https://gitlab.com/adihrustic/Mullvad-WireGuard-Wrapper#listing-servers)
    1. [Connection status](https://gitlab.com/adihrustic/Mullvad-WireGuard-Wrapper#status-of-current-connection)
    1. [Choosing start-up server](https://gitlab.com/adihrustic/Mullvad-WireGuard-Wrapper#choosing-start-up-server)
1. [Troubleshooting](https://gitlab.com/adihrustic/Mullvad-WireGuard-Wrapper#troubleshooting)
1. [More Information](https://gitlab.com/adihrustic/Mullvad-WireGuard-Wrapper#more-information)
1. [Authors](https://gitlab.com/adihrustic/Mullvad-WireGuard-Wrapper#authors)
1. [License](https://gitlab.com/adihrustic/Mullvad-WireGuard-Wrapper#license)


## Prerequisites
* [Mullvad Account](https://mullvad.net/)

```
sudo add-apt-repository ppa:wireguard/wireguard && sudo apt-get update;
sudo apt-get install curl jq openresolv linux-headers-$(uname -r) wireguard-dkms wireguard-tools
```

## Installation
Simply run the following commands in your terminal and follow the instructions
```
cd ./Mullvad-WireGuard-Wrapper/;
sudo ./setup.sh install
```

## Usage
### Connecting to a server
To connect to a server, simply write
```
mullvad connect <server>
```

It it also possible to leave out server selection and connect to the default set server
```
mullvad connect
```

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
When you first update the server list you will be shown the current available servers. To view the list again type
```
mullvad list
```

As of the last update to this wrapper, the available servers are
```
at1:	Wien, Austria
au1:	Sydney, Australia
be1:	Brussels, Belgium
bg1:	Sofia, Bulgaria
br1:	Sao Paulo, Brazil
ca1:	Toronto, Canada
ca2:	Vancouver, Canada
ca3:	Montreal, Canada
ch1:	Zurich, Switzerland
ch2:	Zurich, Switzerland
cz1:	Prague, Czech Republic
de1:	Frankfurt, Germany
de2:	Frankfurt, Germany
de4:	Frankfurt, Germany
de5:	Frankfurt, Germany
dk1:	Copenhagen, Denmark
es1:	Madrid, Spain
fi1:	Helsinki, Finland
fr1:	Paris, France
gb2:	London, UK
gb3:	Manchester, UK
hk1:	Hong Kong, Hong Kong
in1:	Pune, India
it1:	Milan, Italy
jp1:	Tokyo, Japan
md1:	Chisinau, Moldova
nl1:	Amsterdam, Netherlands
nl2:	Amsterdam, Netherlands
nl3:	Amsterdam, Netherlands
no1:	Oslo, Norway
pl1:	Warsaw, Poland
ro1:	Bucharest, Romania
se2:	Stockholm, Sweden
se3:	Gothenburg, Sweden
se4:	Malmö, Sweden
se5:	Gothenburg, Sweden
se6:	Stockholm, Sweden
sg1:	Singapore, Singapore
us1:	New York, NY, USA
us2:	Los Angeles, CA, USA
us3:	Miami, FL, USA
us4:	Chicago, IL, USA
us5:	Seattle, WA, USA
us6:	Atlanta, GA, USA
us7:	Dallas, TX, USA
us9:	Salt Lake City, UT, USA
us11:	Las Vegas, NV, USA
us12:	Los Angeles, CA, USA
us13:	New York, NY, USA
us14:	Piscataway, NJ, USA
us15:	Phoenix, AZ, USA
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

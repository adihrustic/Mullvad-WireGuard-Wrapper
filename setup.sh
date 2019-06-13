#!/bin/bash

TARGET_USER=$SUDO_USER
TARGET_HOME=$(eval echo ~"$SUDO_USER")
CONFIG_ROOT="${TARGET_HOME}/.config/wvpn"
SERVER_LIST="${CONFIG_ROOT}/servers"
DEFAULT_SERVER="${CONFIG_ROOT}/default_server"
DEFAULT_PROVIDER="${CONFIG_ROOT}/provider"

check_root() {
    if [[ ! $UID == 0 ]]; then
        echo "Error: ${0##*/} must be run as root."
        exit 1
    fi
}

settings() {
    while :; do
        echo -en "Choose installation directory (default = /usr/local/bin/):\n> "
        read -r ANS
        if [[ ${ANS} =~ ^.+$ ]]; then
           CMD_ROOT=${ANS}
        else
           CMD_ROOT="/usr/local/bin/"
        fi
        echo -n "Install to ${CMD_ROOT}? [Y/n] "
        read -r ANS
        [[ ${ANS} =~ ^(Y|y|^$)$ ]] && break;
    done

    echo -e "\nChoose your provider: "
    PS3="> "
    options=("Mullvad" "Azire" "Other")
    select opt in "${options[@]}"
    do
        if [[ ${REPLY} == 1 ]]; then
            PROVIDER="https://mullvad.net/media/files/mullvad-wg.sh"
        elif [[ ${REPLY} == 2 ]]; then
            PROVIDER="https://www.azirevpn.com/dl/azirevpn-wg.sh"
        elif [[ ${REPLY} == 3 ]]; then
            while :; do
                echo -en "Please enter the full url to your wireguard config file:\n> "
                read -r ANS
                if [[ ${ANS} =~ ^.+$ ]]; then
                    PROVIDER=${ANS}
                else
                    continue
                fi
                echo -n "Download from ${PROVIDER}? [Y/n] "
                read -r ANS
                [[ ${ANS} =~ ^(Y|y|^$)$ ]] && break;
            done
        fi
        [[ ${PROVIDER} ]] && break
    done

    echo -e "\nChoose whether to use IPv4, IPv6 or both: "
    PS3="> "
    options=("Both (default)" "IPv4" "IPv6")
    select opt in "${options[@]}"
    do
        [[ ${REPLY} == 1 ]] && IP=1
        [[ ${REPLY} == 2 ]] && IP=2
        [[ ${REPLY} == 3 ]] && IP=3
        [[ ${IP} ]] && break
    done

    echo -en "\nTurn on kill-switch for all servers? [Y/n] "
    while :; do
        read -r ANS
        [[ $ANS =~ ^(y|Y|^$)$ ]] && KS_YES=true && break
        [[ $ANS =~ ^(n|N)$ ]] && break
        echo -n "Invalid input, please try again [Y/n] "
    done
}

install() {
    echo -e "\nFetching configuration script"
    curl -sL "${PROVIDER}" -o wvpn-wg.sh

    #Injecting server list construction
    LINE=$(sed -n '/mkdir -p \/etc\/wireguard/=' ./wvpn-wg.sh)
    SERVER="\\\techo \"\$CODE:\t\${SERVER_LOCATIONS[\"\$CODE\"]}\" >> ./servers.tmp"
    sed -i "${LINE}i${SERVER}" ./wvpn-wg.sh

    #Injecting IP version control
    [[ $IP == 1 ]] && ADDRESS_SETTING='$ADDRESS'         #Both
    [[ $IP == 2 ]] && ADDRESS_SETTING='${ADDRESS\/,*\/}' #v4
    [[ $IP == 3 ]] && ADDRESS_SETTING='${ADDRESS\/*,\/}' #v6
    REGEX="s/\(Address = \).*/\1${ADDRESS_SETTING}/"
    sed -i "$REGEX" ./wvpn-wg.sh

    #Injecting config file renaming
    REGEX="s/\(CONFIGURATION_FILE=.*wireguard\/\).*\(-\$CODE.conf\)/\1wvpn\2/"
    sed -i "$REGEX" ./wvpn-wg.sh

    chmod +x ./wvpn-wg.sh
    $(bash ./wvpn-wg.sh) &>/dev/null

    if [[ $KS_YES ]]; then
        PostUp="iptables -I OUTPUT ! -o %i -m mark ! --mark \$(wg show %i fwmark) -m addrtype ! --dst-type LOCAL -j REJECT"
        PostUp=${PostUp/*/"PostUp = $PostUp && ${PostUp//ip/ip6}"}
        PreDown=${PostUp//-I/-D}
        PreDown=${PreDown//PostUp/PreDown}
        echo -e "\nTurning on kill-switch for servers\n"
        for file in /etc/wireguard/wvpn*; do
            sed -i "4a $PostUp\n$PreDown" "$file"
        done
    fi

    mkdir -p "${CONFIG_ROOT}"
    echo "${PROVIDER}" > "${DEFAULT_PROVIDER}"
    sort --version-sort ./servers.tmp > "${SERVER_LIST}"
    echo
    cat "${SERVER_LIST}"
    echo -e "\nFrom the above list, please select a default server:"
    AVAILABLE_SERVERS=$(awk -F':' '{print $1}' "${SERVER_LIST}")
    PS3="> "
    select opt in $AVAILABLE_SERVERS
    do
        grep -q "${opt:-"null"}" <<< "${AVAILABLE_SERVERS}" || continue
        echo "${opt}" > "${DEFAULT_SERVER}"
        break
    done

    chown -R "${TARGET_USER}": "${CONFIG_ROOT}"
    cp ./wvpn ${CMD_ROOT}
    cp ./completion/wvpn /usr/share/bash-completion/completions/
    rm ./servers.tmp ./wvpn-wg.sh
    echo "Installed! Please wait up to 60 seconds for your public key to be added to the servers."
    exit 0
}

uninstall() {
    echo "Removing files..."
    rm "${CMD_ROOT}/wvpn" 2>/dev/null
    rm "/usr/share/bash-completion/completions/wvpn" 2>/dev/null
    rm -r "${CONFIG_ROOT}" 2>/dev/null
    for file in /etc/wireguard/wvpn*; do
        rm "$file" 2>/dev/null
    done
    echo "Removed"
    exit 0
}

case $1 in
    install)
        check_root
        settings
        install
        ;;
    uninstall)
        check_root
        uninstall
        ;;
    *)
        echo "Usage: $(basename "$0") <cmd>"
        echo
        echo -e "install \t Begins the installation"
        echo -e "uninstall \t Uninstalls and removes all files on the machine"
        exit 0
        ;;
esac

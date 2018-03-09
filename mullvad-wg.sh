#!/bin/bash
#
# Copyright (C) 2016-2017 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
#
# This file is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# as published by the Free Software Foundation.
#
# This file is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this file. If not, see <http://www.gnu.org/licenses/>.

set -e

die() {
	echo "[-] Error: $1" >&2
	exit 1
}

PROGRAM="${0##*/}"
ARGS=( "$@" )
SELF="$(readlink -f "${BASH_SOURCE[0]}")"
[[ $UID == 0 ]] || exec sudo -p "[?] $PROGRAM must be run as root. Please enter the password for %u to continue: " "$SELF" "${ARGS[@]}"

read -p "[?] Please enter your Mullvad account number: " -r ACCOUNT

echo "[+] Downloading Mullvad server list."
declare -A SERVER_ENDPOINTS
declare -A SERVER_PUBLIC_KEYS
declare -A SERVER_LOCATIONS
declare -a SERVER_CODES
# TODO: hook this up to a real API in the future, instead of this terrible kludge
SERVER_GUIDE="$(curl -sSL https://mullvad.net/guides/our-vpn-servers/)" || die "Could not download server list."
trim() {
	local var="$2"
	var="${var#"${var%%[![:space:]]*}"}"
	var="${var%"${var##*[![:space:]]}"}"
	printf -v "$1" %s "$var"
}
while read -r line; do
	[[ $line =~ ^([a-z]{2}[0-9]{1,2})-wireguard\.mullvad\.net\ *\| ]] || continue
	CODE="${BASH_REMATCH[1]}"
	IFS='|' read -r HOST COUNTRY CITY _ _ PUBLIC_KEY <<<"$line"
	trim HOST "$HOST"
	trim COUNTRY "$COUNTRY"
	trim CITY "$CITY"
	trim PUBLIC_KEY "$PUBLIC_KEY"
	SERVER_ENDPOINTS[$CODE]="$HOST:51820"
	SERVER_PUBLIC_KEYS[$CODE]="$PUBLIC_KEY"
	SERVER_LOCATIONS[$CODE]="$CITY, $COUNTRY"
	SERVER_CODES+=( "$CODE" )
done <<<"$SERVER_GUIDE"

shopt -s nocasematch
for CODE in "${SERVER_CODES[@]}"; do
	CONFIGURATION_FILE="/etc/wireguard/mullvad-$CODE.conf"
	[[ -f $CONFIGURATION_FILE ]] || continue
	while read -r line; do
		[[ $line =~ ^PrivateKey\ *=\ *([a-zA-Z0-9+/]{43}=)\ *$ ]] && PRIVATE_KEY="${BASH_REMATCH[1]}" && break
	done < "$CONFIGURATION_FILE"
	[[ -n $PRIVATE_KEY ]] && echo "[+] Using existing private key." && break
done
shopt -u nocasematch

if [[ -z $PRIVATE_KEY ]]; then
	echo "[+] Generating new private key."
	PRIVATE_KEY="$(wg genkey)"
fi

echo "[+] Contacting Mullvad API."
RESPONSE="$(curl -sSL https://api.mullvad.net/wg/ -d account="$ACCOUNT" --data-urlencode pubkey="$(wg pubkey <<<"$PRIVATE_KEY")")" || die "Could not talk to Mullvad API."
[[ $RESPONSE =~ ^[0-9a-f:/.,]+$ ]] || die "$RESPONSE"
ADDRESS="$RESPONSE"
DNS="193.138.219.228"

echo "[+] Writing WriteGuard configuration files."
for CODE in "${SERVER_CODES[@]}"; do
	CONFIGURATION_FILE="/etc/wireguard/mullvad-$CODE.conf"
	umask 077
	mkdir -p /etc/wireguard/
	rm -f "$CONFIGURATION_FILE.tmp"
	cat > "$CONFIGURATION_FILE.tmp" <<-_EOF
		[Interface]
		PrivateKey = $PRIVATE_KEY
		Address = $ADDRESS
		DNS = $DNS

		[Peer]
		PublicKey = ${SERVER_PUBLIC_KEYS[$CODE]}
		Endpoint = ${SERVER_ENDPOINTS[$CODE]}
		AllowedIPs = 0.0.0.0/0, ::/0
	_EOF
	mv "$CONFIGURATION_FILE.tmp" "$CONFIGURATION_FILE"
done

echo "[+] Success. The following commands may be run for connecting to Mullvad:"
for CODE in "${SERVER_CODES[@]}"; do
	echo "- ${SERVER_LOCATIONS[$CODE]}:"
	echo "  \$ wg-quick up mullvad-$CODE"
done

echo "Please wait up to 60 seconds for your public key to be added to the servers."

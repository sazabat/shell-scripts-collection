#!/bin/bash

#OVPN_CONFIG="your_openvpn_configuration_file.ovpn"

openvpn3 config-import --config OVPN_CONFIG --name CUSTOM_VPN_CONNECTION
openvpn3 config-manage --config CUSTOM_VPN_CONNECTION --allow-compression yes
openvpn3 session-start --config CUSTOM_VPN_CONNECTION
openvpn3 configs-list -v

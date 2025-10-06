#!/bin/bash

#OVPN_CONFIG="your_openvpn_configuration_file.ovpn"

for session in $(openvpn3 sessions-list | grep Path | awk '{print $2}'); do
    echo "Removing session: $session"
    openvpn3 session-manage --session-path "$session" --disconnect
done

openvpn3 config-remove --config "$OVPN_CONFIG" --force

#!/bin/bash

# Find the VPN virtual interface on the computer and see if they have an IP

int_server="internal.net"

# Detection code thanks to Ben Reilly but modified somewhat
# Can we get a route to a known internal address? Test for error.
test=$( route get "$int_server" )
test=$?

# If no error, get the name of the interface we got success from.
if [ $test = "0" ];
then
        pulse_iface=$( route get "$int_server" | grep interface: | grep -v "en" | awk '{ print $2 }' )
fi

# Does the VPN have an IP address
if [ ! $pulse_iface = "" ];
then    
        IP_VPN=$( ifconfig "$pulse_iface" | grep "inet " | awk '{ print $2 }' )
fi

# No IP? Warning otherwise show ok.
if [ $IP_VPN = "" ];
then
        echo "hitp-state: none"
else
        echo "hitp-state: ok"
fi

# If IP display it, otherwise warn.
if [ ! -z $IP_VPN ];
then
        echo "hitp-enabled: YES"
        echo "hitp-hidden: NO"
        echo "hitp-title: VPN : $IP_VPN"
else
        echo "hitp-enabled: NO"
        echo "hitp-hidden: YES"
        echo "hitp-title: VPN not connected"
fi

exit 0
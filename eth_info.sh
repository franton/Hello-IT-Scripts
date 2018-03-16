#!/bin/bash

# Find all wifi ports on the computer and see if they have an IP

AIRINT=$(networksetup -listallhardwareports | grep -A1 -i 'wi-fi\|airport' | grep en | grep -o "[^ ]*$")

if [ "$AIRINT" != "" ];
then
	IP_AIR=$(ipconfig getifaddr $AIRINT)
fi

# Find all ethernet ports on the computer and see if they have an IP

for ethernet in $(networksetup -listallhardwareports | grep -A1 'Ethernet' | grep en | grep -o "[^ ]*$")
do
	test=$( ifconfig $ethernet | grep "status: active" )
	
	if [ "$test" != "" ];
	then
		ETHINT=$ethernet
	fi
done

IP_ETH=`ipconfig getifaddr $ETHINT`

if [[ $IP_AIR = "" ]] && [[ $IP_ETH = "" ]];
then
	echo "hitp-state: warning"
else
	echo "hitp-state: ok"
fi

if [ ! -z "$IP_ETH" ];
then
	echo "hitp-enabled: YES"
	echo "hitp-hidden: NO"
	echo "hitp-title: Ethernet : $IP_ETH"
else
	echo "hitp-enabled: NO"
	echo "hitp-hidden: YES"
	echo "hitp-title: No Ethernet Address"
fi

exit 0
#!/bin/bash

# Script to report current JSS building to Hello-IT

buildfile="/usr/local/cs/misc/building"

echo "hitp-enabled: YES"
echo "hitp-hidden: NO"

if [ -e "$buildfile" ];
then
	building=$( cat "$deptfile" )
	echo "hitp-title: Country : $building"
	echo "hitp-state: ok"
else
	echo "hitp-title: Missing Country Info"
	echo "hitp-state: unavailable"
fi

exit 0

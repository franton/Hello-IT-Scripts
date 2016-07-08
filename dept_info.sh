#!/bin/bash

# Script to report current JSS department to Hello-IT

deptfile="/usr/local/cs/misc/department"

echo "hitp-enabled: YES"
echo "hitp-hidden: NO"

if [ -e "$deptfile" ];
then
	department=$( cat "$deptfile" )
	echo "hitp-title: Department : $department"
	echo "hitp-state: ok"
else
	echo "hitp-title: Missing Department Info"
	echo "hitp-state: unavailable"
fi

exit 0

#!/bin/bash

# Script to report current JSS building to Hello-IT

# Set up variables here

jamf_binary=`/usr/bin/which jamf`

if [[ "$jamf_binary" == "" ]] && [[ -e "/usr/sbin/jamf" ]] && [[ ! -e "/usr/local/bin/jamf" ]]; then
	jb="/usr/sbin/jamf"
elif [[ "$jamf_binary" == "" ]] && [[ ! -e "/usr/sbin/jamf" ]] && [[ -e "/usr/local/bin/jamf" ]]; then
	jb="/usr/local/bin/jamf"
elif [[ "$jamf_binary" == "" ]] && [[ -e "/usr/sbin/jamf" ]] && [[ -e "/usr/local/bin/jamf" ]]; then
	jb="/usr/local/bin/jamf"
elif [[ "$jamf_binary" == "" ]] && [[ ! -e "/usr/sbin/jamf" ]] && [[ ! -e "/usr/local/bin/jamf" ]]; then
	jb="error"
fi

echo "hitp-enabled: YES"
echo "hitp-hidden: NO"

if [ "$jb" = "error" ];
then
	echo "hitp-title: Not Enrolled"
	echo "hitp-state: error"
	exit 1
fi

jsstest=$( $jb checkJSSConnection | grep "Available" )

if [ "$jsstest" != "The JSS is available." ];
then
	echo "hitp-title: Not Available"
	echo "hitp-state: unavailable"
	exit 1
fi

echo "hitp-title: Enrolled"
echo "hitp-state: ok"

exit 0
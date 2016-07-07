#!/bin/bash

# Script to report current JSS department to Hello-IT

# Set up variables here

apiuser="apiusr"
apipass="apiusrpw"

echo "hitp-enabled: YES"
echo "hitp-hidden: NO"

jssurl=$( defaults read /Library/Preferences/com.jamfsoftware.jamf "jss_url" 2> /dev/null )

if [ "$jssurl" = "" ];
then
	echo "hitp-title: Not Enrolled"
	echo "hitp-state: error"
	exit 1
fi

department=$(curl -H "Accept: application/xml" -s -u "$apiuser:$apipass" "${jssurl}JSSResource/computers/udid/$udid/subset/location" | xpath "//computer/location/department/text()" 2> /dev/null)

if [ "$department" = "" ];
then
	echo "hitp-title: Missing Department Info"
	echo "hitp-state: unavailable"	
	exit 1
fi

echo "hitp-title: Department : $department"
echo "hitp-state: ok"

exit 0
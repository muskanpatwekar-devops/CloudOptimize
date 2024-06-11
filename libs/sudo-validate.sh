#!/bin/bash

# Description

# Defining variables

Root_userId="0"
Logged_userId="$(id -u)"


# Main program execution

echo "Validate a script is running with the sudo privilege"

# sanity check

if [[ $Logged_userId -eq $Root_userId ]] ; then
echo "Info : script is executed with the sudo privilege"
echo "Current user id $Logged_userId"
else
echo "Error:-Please re-run the script with sudo privilege"
echo "script is executed with  user id $Logged_userId"
exit 1
fi



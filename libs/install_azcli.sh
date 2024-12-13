#!/bin/bash

# echo "Info:Installing cloud command line utilities for azure"

# # Sanity check if aws is already installed

# command -v az < /dev/null 

# RETURN_CODE=${?}

# if [[ ${RETURN_CODE} -ne 0 ]]; then
# echo "Info : Installing azure cli.........."

# # Installing the pre-requisties tools for az cli installation

# apt-get update -y > /dev/null 
# apt-get install curl -y > /dev/null 

# # Downloading the azi cli 

# mkdir /opt/scripts

# curl -sL https://aka.ms/InstallAzureCLIDeb > /opt/scripts/install_az.sh
# chmod +x /opt/scripts/install_az.sh

# /opt/scripts/install_az.sh > /dev/null 

# # Post installation sanity check for azure cli

# if  command -v az > /dev/null; then
# echo " Info : Insatallation of az cli is sucessfulled"
# else
# echo "Error : Something went wrong while installing"
# exit 1
# fi

# else
# echo " Az cli is already installed"
# fi



 
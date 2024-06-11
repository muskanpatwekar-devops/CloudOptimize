#!/bin/bash

echo "Info:Installing cloud command line utilities for aws"

# Sanity check -if aws cli is allready installed

command -v aws >/dev/null

RETURN_CODE="${?}"

if [[ $RETURN_CODE -ne 0 ]]; then
echo "Info :Installing the aws cli..."

#Download zip aws cli and store in tmp directory

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"

#Extract the zip file and store in opt directory

unzip /tmp/awscliv2.zip -d /opt > /dev/null

# Delete the tmp file

rm -f /tmp/awscliv2.zip
/opt/aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli

#Post installation check
 if command -v aws > /dev/null; then
 echo "INFO: AWS cli successfully installed."
  else
    echo "ERROR: Something went wrong while installing AWS cli."
    exit 1
  fi

else
  echo "INFO: AWS CLI is already installed, skipping installation."
fi




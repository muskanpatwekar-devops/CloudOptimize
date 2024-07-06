#!/bin/bash
#
#
#
#
#======================================================================================================
#=====================================FUNCTIONS=======================================================
#======================================================================================================

# Set AWS authN variable........ 
aws_auth(){
AWS_ACCESS_KEY_ID=$(yq -r '.auth_config.aws.access_key' $CREDENTIAL_FILE)
AWS_SECRET_ACCESS_KEY=$(yq -r '.auth_config.aws.secret_access_key' $CREDENTIAL_FILE)
AWS_REGION=$(yq -r '.auth_config.aws.region' $CREDENTIAL_FILE)
AWS_OUTPUT=$(yq -r '.auth_config.aws.output' $CREDENTIAL_FILE)

aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set region $AWS_REGION
aws configure set output $AWS_OUTPUT

if aws sts get-caller-identity > /dev/null 2>&1; then
IAM_USERNAME=$(aws sts get-caller-identity --query 'Arn' --output text | awk -F"/" '{print $2}')
echo "INFO: User is successfully logged in $IAM_USERNAME"
else
echo "ERROR : Unexpected error accur while authenticating the IAM USER"
exit 1
fi 
}
# Set azure authN variable 
az_auth(){
AZURE_CLIENT_ID=$(yq -r '.auth_config.azure.client_id' $CREDENTIAL_FILE)
AZURE_CLIENT_SECRET=$(yq -r '.auth_config.azure.client_secret' $CREDENTIAL_FILE)
AZURE_SUBSCRIPTION_ID=$(yq -r '.auth_config.azure.subscription_id' $CREDENTIAL_FILE)
AZURE_TENANT_ID=$(yq -r '.auth_config.azure.tenant_id' $CREDENTIAL_FILE)

az login --service-principal \
-u $AZURE_CLIENT_ID \
-p $AZURE_CLIENT_SECRET \
--tenant $AZURE_TENANT_ID \
--allow-no-subscription > /dev/null

#  set active subscription
az account set --subscription "${AZURE_SUBSCRIPTION_ID}" 

if az account show > /dev/null 2>&1; then

  AZURE_APP_NAME=$(az ad sp show --id "$(az account show --query 'user.name' -o tsv)" --query appDisplayName -o tsv)
  echo "INFO: Successfully logged in with Azure App ${AZURE_APP_NAME}"
else
  echo "ERROR: Unexpected error occured while authenticating with AZ CLI command."
  exit 1
fi
}
#======================================================================================================
#=====================================variable=======================================================
#======================================================================================================
# DEFINE VARIABLE

CREDENTIAL_FILE=".cof/csp_auth.yaml"

#~/.cof/csp_auth.yaml
#.cof/csp_auth.yaml
#======================================================================================================
#===============================Main program============================================================
#======================================================================================================

if [[ ! -f "$HOME/$CREDENTIAL_FILE" ]]; then
echo "EEROR: AuthN file  NOT found  ~/$CREDENTIAL_FILE "



if [[ -f $CREDENTIAL_FILE ]]; then
echo "EEROR: AuthN file  NOT found  $CREDENTIAL_FILE. Aborting"
fi
fi



if ! command -v yq > /dev/null 2>&1; then
echo "Error : yq command not found,please install"
exit 1
fi

# calling function aws
aws_auth
# calling function az
az_auth

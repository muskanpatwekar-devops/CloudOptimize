#!/bin/bash
#
#
# File variable

OUTPUT_CSV_FILE=instance-report.csv

#  Add header for csv file
echo "CLOUD_PROVIDER,INSTANCE_NAME,INSTANCE_IP,INSTANCE_STATE,DATE,TAGS" > $OUTPUT_CSV_FILE

# ---------------------------------------
# AWS: Capture aws ec2 instance state 
# ---------------------------------------

for instance_id in $(aws ec2 describe-instances --filter "Name=tag:shutdown,Values=true" --query "Reservations[].Instances[].InstanceId" --output text); do

INSTANCE_NAME=$(aws ec2 describe-tags --filters "Name=resource-id,Values=${instance_id}" --query "Tags[?Key=='Name'].Value" --output text)

INSTANCE_IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${INSTANCE_NAME}" --query 'Reservations[].Instances[].PrivateIpAddress' --output text)

INSTANCE_STATE=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${INSTANCE_NAME}" --query 'Reservations[].Instances[].State.Name' --output text)

DATESTAMP=$(date +%Y%m%d-%H%M%S)

echo "aws,${INSTANCE_NAME},${INSTANCE_IP},${INSTANCE_STATE},${DATESTAMP},${DATESTAMP},shutdown" >> $OUTPUT_CSV_FILE

done

# # -------------------------------------------
# # Azure: Capture azure virtual machine state 
# # --------------------------------------------
# for rg_name in $(az group list --query "[].name" -o tsv | grep -vE "${IGNORE_RESOURCE_GROUPS}"); do
#   for azvm_name in $(az vm list -g ${rg_name} --query "[?tags.shutdown=='true'].name" -o tsv); do
    
#     echo "INFO: fetching details of Azure Virtual Machine ${azvm_name}."

#     azvm_ip=$(az vm show -d --name ${azvm_name} -g ${rg_name} --query 'privateIps' -o tsv)
#     azvm_state=$(az vm show -d --name ${azvm_name} -g ${rg_name} --query 'powerState' -o tsv | awk '{print $NF}')
#     datestamp=$(date +%Y%m%d-%H%M%S)
    
#     echo "azure,${azvm_name},${azvm_ip},${azvm_state},${datestamp},shutdown" >> $OUTPUT_CSV_FILE
#   done
# done
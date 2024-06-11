#!/bin/bash

CSV_INSTANCE_REPORT=instance-report.csv
HTML_TEMPLATE_FILE=../template/email-content.html.tpl
RENDERED_HTML_FILE="rendered-email-content.html"
TABLE_ROWS=""


for line in $(grep -vE "^CLOUD_PROVIDER" ${CSV_INSTANCE_REPORT}); do
cloud_provider=$(echo ${line} | awk -F "," '{print $1}')  
instance_name=$(echo ${line} | awk -F"," '{print $2}')
instance_ip=$(echo ${line} | awk -F "," '{print $3}')
instance_status=$(echo ${line} | awk -F "," '{print $4}')
instance_stutdown_time=$(echo ${line} | awk -F "," '{print $5}')
instance_tag=$(echo ${line} | awk -F "," '{print $NF}')

TABLE_ROWS+="
<tr>
<td>$cloud_provider</td>
<td>$instance_name</td>
<td>$instance_ip</td>
<td>$instance_status</td>
<td>$instance_stutdown_time</td>
<td>$instance_tag</td>
</tr>
"
done
# Read html tempalte

HTML_FILE=$(cat "${HTML_TEMPLATE_FILE}")

# Replace the placeholder with actual table rows using bash parameter expansion
# ${variable//pattern/replacement}
HTML_FILE=${HTML_FILE//__TABLE_ROWS_PLACEHOLDR__/$TABLE_ROWS}
HTML_FILE=${HTML_FILE//__TIME_STAMP__/$(date)}

# Write HTML template to the output file

echo "$HTML_FILE" > $RENDERED_HTML_FILE

echo "INFO: HTML email template with table rows and data has been generated. Output file: ${RENDERED_HTML_FILE}"
#!/bin/bash
# Author: savigliano
# Author: github.com/wohper

DATASET=$1;

for LINE in $(cat ${DATASET} | awk  '($2 == "Web"){print $0}' | tr "\t" "|" | tr -d "\040"); do

	#echo $LINE

	CODE=$(echo $LINE | awk -F\| '{print $1}');
	DOMAIN=$(echo $LINE | awk -F\| '{print $3}' | awk -F\/ '{print $3}' | sed 's/www\.//g' );

	#echo ${DOMAIN}

	MX=$(host -t MX "${DOMAIN}")
	
	GOOGLE=$(echo $MX | grep -i googlemail.com);
	OUTLOOK=$(echo $MX | grep -i protection.outlook.com);
	
	if [ ! -z "${GOOGLE}" ]; then
		echo "RESULT: ${DOMAIN} (${CODE}) has MX in Google"
		echo "${MX}"
	fi
	
	if [ ! -z "${OUTLOOK}" ]; then
		echo "RESULT: ${DOMAIN} (${CODE}) has MX in Outlook"
		echo "${MX}"
	fi	
	
	>&2 echo -n "."
	
done

#!/bin/bash
# Author: github.com/wohper

TOKEN=$(awk -F'=' '/^TOKEN/ { print $2 }' .env)
DATASET=$1;
DATAOUT=$2;

usage(){
	echo "$0 [DATASET FILE] [DATAOUT DIR]"
}

[ ! -f "$DATASET" ] && { usage; exit 1; }
[ ! -d "$DATAOUT" ] && { usage; exit 1; }


for LINE in $(cat ${DATASET} | awk  '($2 == "Web"){print $0}' | tr "\t" "|" | tr -d "\040"); do

	echo '======================================'

	CODE=$(echo $LINE | awk -F\| '{print $1}');
	DOMAIN=$(echo $LINE | awk -F\| '{print $3}' | awk -F\/ '{print $3}');

	for IP in $(host "${DOMAIN}" | grep 'has address' | awk '{print $NF}'); do

		FILENAME="${CODE}_$(echo ${DOMAIN} | tr A-Z a-z | tr "\040", "_")_${IP}";

		if [ ! -f "${DATAOUT}/location_${FILENAME}.json" ]; then

			echo "#${CODE}|${DOMAIN}|${IP}" > ${DATAOUT}/location_${FILENAME}.json
			curl "https://ipinfo.io/${IP}?token=${TOKEN}" 2> /dev/null | tee -a ${DATAOUT}/location_${FILENAME}.json

		else

			echo "${DATAOUT}/${FILENAME} exists!"

		fi

	done

done

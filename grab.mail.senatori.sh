#!/bin/bash
# Minimal and brutal by wohper
# Sostituire 18 con altro valore per cambiare legislatura
# usage: $0 | tee -a output.psv

URLCOLLECTION=$(mktemp /tmp/senato-links.XXXXX)
TMPFILE=$(mktemp /tmp/senato-page.XXXXX)

# Scarico tutte le pagine per lettera
for L in {a..z}; do
	elinks --dump https://www.senato.it/leg/18/BGT/Schede/Attsen/Sen${L}.html | grep 'https://www.senato.it/loc/link.asp?tipodoc=sattsen&leg=18&id=' | awk '{print $2}' >> $URLCOLLECTION
	>&2 echo -n "$L"
done

# Per ogni URL
for URL in $(cat $URLCOLLECTION); do
	curl -L "${URL}" 2> /dev/null > ${TMPFILE}
	NAME=$(cat ${TMPFILE} | sed -n 's/<h1 class="titolo">\(.*\)<\/h1>/\1/Ip' | sed -e 's/^[[:space:]]*//' | tr -d "\r")
	MAIL=$(cat ${TMPFILE} 2> /dev/null | grep document.write | head -1 | grep -E -o "\b([A-Za-z0-9.]+@senato.it)")
	echo "${NAME}|${MAIL}|${URL}"
	>&2 echo -n "."
done

rm -f ${TMPFILE} ${URLCOLLECTION}

>&2 echo "Fatto."

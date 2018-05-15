#!/bin/bash

LESSON="$(pwd | egrep -o '\w+/lezioni' | cut -d '/' -f 1)"
if [ -z $LESSON ]; then
	echo "Invalid path $(pwd)"
	exit 1
fi
FILE='lezione.md'
case $LESSON in
	so )
		HEADER='###### Sistemi Operativi - prof - '`date +%d/%m/%Y`
		;;
	prowm )
		HEADER='###### Programmazione Web e Mobile - Pirrone - '`date +%d/%m/%Y`
		;;
	bigdata )
		HEADER='###### Big data & Analytics - Ferraro - '`date +%d/%m/%Y`
		;;
	* )
		echo "$LESSON is not a valid lesson"
		exit 1
		;;
esac

# check file existence
if [ -e $FILE ]; then
	echo "$FILE already exists!"
	exit 1
fi

cat << EOF > $FILE
<style>body{margin: auto;width: 90%;max-width: 100%;}</style>

$HEADER
EOF
echo "$FILE created!"

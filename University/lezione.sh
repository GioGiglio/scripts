#!/bin/bash
# author Giovanni Giglio (@GioGiglio)
# description: creates a lezione.md file (if it doesn't exist yet) and initialize it with an header based on the name of the lesson

# check args
if [ $# -gt 0 ]; then
	echo "$0: no args expected"
	exit 1
fi

FILE='lezione.md'
LESSON="$(pwd | grep -oP '\w+(?=/lezioni)')"
DATE="$(date +%d/%m/%Y)"

# check if $LESSON has a valid value
if [ -z "$LESSON" ]; then
	echo "Invalid path $(pwd)"
	exit 1
fi

case $LESSON in
	so )
		HEADER='###### Sistemi Operativi - prof - '$DATE
		;;
	prowm )
		HEADER='###### Programmazione Web e Mobile - Pirrone - '$DATE
		;;
	bigdata )
		HEADER='###### Big data & Analytics - Ferraro - '$DATE
		;;
	* )
		echo "$LESSON is not a valid lesson!"
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

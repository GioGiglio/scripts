#!/bin/bash
# author: Giovanni Giglio (@GioGiglio)
# description: creates a lezione.md file (if it doesn't exist yet) and initialize it with some css style rules an header based on the name of the lesson

# parse args
ARG_O=0

if [ $# -gt 0 ]; then
	case "$1" in
	-o | --open)
		ARG_O=1
		;;
	*)
		echo "$0: $1: Invalid argument"
		exit 1
	esac
fi

FILE='lezione.md'
LESSON="$(pwd | grep -oP '\w+(?=/lezioni)')"
DATE="$(date +%d/%m/%Y)"

# check if $LESSON has a valid value
if [ -z "$LESSON" ]; then
	echo "Invalid path $(pwd)"
	exit 1
fi

# check file existence
if [ -e $FILE ]; then
	echo "$FILE already exists!"
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

cat << EOF > $FILE
<style>
body{margin: auto;width: 90%;max-width: 100%;border:0;}
body .markdown-body{padding:0;}
@media only print{
	ul {
		page-break-inside: avoid;
	}
	ol > li {
		page-break-inside: avoid;
	}
	a {
		text-decoration: none !important;
	}
	blockquote {
		margin: 1px solid black;
	}
}
</style>
$HEADER

EOF
echo "$FILE created!"

if [ $ARG_O -gt 0 ]; then
	xdg-open $FILE &> /dev/null &
fi

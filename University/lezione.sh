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
<style>
body{margin: auto;width: 90%;max-width: 100%;border:0;}
body .markdown-body{padding:0;}
@font-face {
    font-family: "lato";
    src:url("file:///home/gio/.myfonts/lato/Lato-Regular.ttf");
}
* { font-family:"lato"; }
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

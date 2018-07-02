#!/bin/bash
#
# Author:       Giovanni Giglio
# Email:        giovannimaria.giglio@gmail.com
# Description:  Creates a lezione.md file (if it doesn't already exist) 
#               and fills it with some css style rules and an header based on the name of the lesson
#               and the current date.
# Usage:        cd <lesson root directory> && lezione [-o]

function error_exit {
	echo "${progname}: ${1:-"Unknown error"}" 1>&2
	exit 1
}

function checks {
	# parse args #
	while [[ $# -gt 0 ]]; do
		case "$1" in
		-o | --open)
			arg_o=
			shift
			;;
		*)
			error_exit "Invalid option $1"
		esac
	done

	# check file existence #
	if [ -e $file ]; then
		error_exit "$file already exists!"
	fi

	# init vars #
	lesson=$(pwd | grep -oP '\w+(?=/lezioni)')
	date="$(date +%d/%m/%Y)"

	# check if $lesson has a valid value #
	if [ -z "$lesson" ]; then
		error_exit "Invalid path $(pwd)"
	fi

	# assing $header based on $lesson #
	case $lesson in
		so )
			header='###### Sistemi Operativi - prof - '$date
			;;
		prowm )
			header='###### Programmazione Web e Mobile - Pirrone - '$date
			;;
		bigdata )
			header='###### Big data & Analytics - Ferraro - '$date
			;;
		* )
			error_exit "Invalid lesson $lesson"
			;;
	esac
}

function main {

	# fill $file #
	cat << EOF > $file
<style>
body{margin: auto;width: 90%;max-width: 100%;}
* { font-family:"lato"; }
@media only print{
	body{border:0;}
	body .markdown-body{padding:0;}
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
$header

EOF

	echo "$file created!"

	if ! [ -z ${arg_o+x} ]; then
		echo "Opening ${file}..."
		xdg-open $file &> /dev/null &
	fi
}

# Start point #
progname=$(basename $0)
file='lezione.md'

checks $@ && main
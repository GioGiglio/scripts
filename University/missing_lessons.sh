#!/usr/bin/env bash
#
# Author:       Giovanni Giglio
# Email:        giovannimaria.giglio@gmail.com
# Description:  Prints all the lesson directories where there isn't the 'lezione.html' file
# Usage:        missing_lessons

find_missing (){
	local dir

	cd "$basedir"
    for dir in */lezioni/*; do
        if ! [ -e "${dir}/lezione.html" ]; then
            echo "$dir"
        fi
    done
}

# Starting point #
basedir="$MAG"
shopt -s nullglob

find_missing

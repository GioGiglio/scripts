#!/bin/bash

SCRIPT_NAME="$(basename $0)"
if [ $# -gt 1 ]; then
	echo "usage: $SCRIPT_NAME [-y | -l]"
	exit 1
fi

# parse args
ARG_Y=""
ARG_L=0

if [ $# -gt 0 ]; then
	case "$1" in
	-y |--year)
		ARG_Y="%y-"
		;;
	-l | --last)
		ARG_L=1
		;;
	*)
		echo "$SCRIPT_NAME: $1: Invalid argument"
		exit 1
	esac
fi

if [ $ARG_L -gt 0 ]; then
	echo "$(ls -l | awk '$1 ~ /^d/ {print $NF}' | grep -P '\d{2}-\d{2}' | tail -n 1)"
	exit 0
fi

DIR="$(date +$ARG_Y%m-%d)"
mkdir $DIR 2> /dev/null

if [ $? -gt 0 ]; then
	echo "$SCRIPT_NAME: Error while creating $DIR"
	exit 1
else
	echo "$DIR created"
fi

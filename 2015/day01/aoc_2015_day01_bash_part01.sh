#!/bin/bash
floor=0;
#[[ ! -f "$1" ]] && { echo -en "error: no input file"; kill -INT $$; }
cat "$1"|fold -1 | while read line; do
	case $line in
		"(") (( floor++ )) ;;
		")") (( floor-- )) ;;
	esac;
#echo "$floor"
done
echo "$floor";

#!/bin/bash
# check if the argument to the script is a file; and then
if [[ -f "$1" ]]; then
	datafile="$1";
	# clear the little sum variable
	sum=0
	# begin processing of the "datafile"
	while read line; do
		# the fuck is this... oh, ok, yeah, ok, so the $line is the current line of the datafile, which is echoed,
		# and at the same time sed will replace " " with "\n", piping it to sort wihch sorts it as numeric, which
		# in turn is piped to tail who picks the very last line, which is the greatest number
		#   MINUS
		# the same thing, but instead of tail we're piping it to head, which takes the smallest number since that's on top of the list
		let sum=$(( sum + $(( $(echo $line|sed 's/ /\n/g'|sort -n|tail -n1) - $(echo $line|sed 's/ /\n/g'|sort -n|head -n1) )) ))
	# and the loop gets it input from $datafile
	done < $datafile
	# this creates kind of an echo cho ho of the $sum
	echo "the result of what I'm not actually completely sure of what it IS right now when I'm typing this, is nevertheless as follows: $sum"
#otherwise
else	# $(basename "$0") gives the actual filename of the script. and with $0 in quotation marks, it manages spaces as well.
	echo -e "usage: $(basename "$0") [datafile]\n\twhere [datafile] is a file. with data."
fi


# and the one-liner:
# datafile=datafile.day02; sum=0; while read line; do let sum=$(( sum + $(( $(echo $line|sed 's/ /\n/g'|sort -n|tail -n1) - $(echo $line|sed 's/ /\n/g'|sort -n|head -n1) )) )); done < $datafile; echo "the result of what I'm not actually completely sure of what it IS right now when I'm typing this, is nevertheless as follows: $sum"; 

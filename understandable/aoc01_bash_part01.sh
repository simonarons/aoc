#!/bin/bash
digits="$1" # this only takes the first argument, i.e. nothing other than digits, digits or digits
# verify that $digits are digits and only digits
if [[ $digits =~ ^[0-9]+$ ]]; then
	# set/reset some variables
	sum=0; pos=0
	# commence loop
	# as long as $pos(ition) is less than number of digits in array digits; do
	while [[ $pos -lt ${#digits} ]]; do 
		# if the current $pos is the same as the $previous; then
		if [[ ${digits:$pos:1} == ${digits:$pos-1:1} ]]; then
			# add a tiny lite 1 to the sum
			let sum=sum+${digits:$pos:1}
		fi
		# increase $pos with 1, rinse and repeat
		let pos++
	done
	echo "result: $sum"
else
	echo "your input is not just digits, or nothing. not ok."
fi

# and the mandatory boiled-down hard-to-read optimized one-liner:
# [[ -f "$1" ]] && { datafile="$1"; sum=0; while read line; do let sum=$(( sum + $(( $(echo $line|sed 's/ /\n/g'|sort -n|tail -n1) - $(echo $line|sed 's/ /\n/g'|sort -n|head -n1) )) )); done < $datafile; echo "$sum"; } || echo -e "usage: $(basename "$0") [datafile]\nwhere datafile is a file. with data."

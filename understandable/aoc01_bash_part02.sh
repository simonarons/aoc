#!/bin/bash
digits="$1" # this only takes the first argument, i.e. nothing other than digits, digits or digits
# verify that $digits are digits and only digits
if [[ $digits =~ ^[0-9]+$ ]]; then
	# set/reset some variables
	sum=0; pos=0
	# commence loop
	# as long as $pos(ition) is less than number of digits in array digits; do
	while [[ $pos -lt ${#digits} ]]; do
		# i'm just realizing that this might be very stupid, but anyhow: if $pos is in the lesser half of the number of digits, it...
		if [[ $pos -lt $((${#digits}/2)) ]]; then
			# ...looks if the current digit is same as the one 180 degrees away, or in this case the position from this + half of the number of digits
			if [[ ${digits:$pos:1} == ${digits:$(($pos+${#digits}/2)):1} ]]; then
				# and add a little tiny 1 to the sum
				let sum=sum+${digits:$pos:1};
			fi
		else
			# hmm, I wonder what I was thinking here, feels like this could be smarter, but this half is only valid if the position is not on the lesser half of the number of digits
			# otherwise pretty much the same as above, except it's a minus instead of a +, i.e. looking from this position - half of the number of digits.
			if [[ ${digits:$pos:1} == ${digits:$(($pos-${#digits}/2)):1} ]]; then
				let sum=sum+${digits:$pos:1};
			fi
		fi
		# increase $pos with 1, rinse and repeat
		let pos++
	done
	echo "result: $sum"
else
	echo "your input is not just digits, or nothing. not ok."
fi


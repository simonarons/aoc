#!/bin/bash
# check if the argument to the script is a file; and then
if [[ -f "$1" ]]; then
	datafile="$1";
	# unsettling stuff
	sum=0; unset a i
	# begin processing of the "datafile"
	while read line; do
		# each line into an array for processing ze data
		data=($(echo $line));
		# now for some loop-o-rama. first iterate through the array
		for i in ${data[@]}; do
			# now we'll do another loop and test if any of the elements is evenly dividable
			for a in ${data[@]}; do
				# don't divide yourself, it's not christian and frankly disgusting
				if [[ $i != $a ]]; then
					# test if there's anything left after divide
					if [[ $(( $i % $a )) == 0 ]]; then
						# and if there's nothing left, then we divide those two numbers and add them to $sum
						let sum=sum+$(( $i / $a ));
					fi
				fi
			done
		done
	# and we're back, accepting input from the datafile	
	done < $datafile
	# now, for the grande finale:
	echo "the result of whatever it is, is $sum"
# but if there was no datafile given in the argument... 
else
	# we'll unleash hell upon the user:
	echo -e "usage: $(basename "$0") [datafile]\n\twhere [datafile] is a file. with data."
fi


# and the one-of-a-kind-liner:
#[[ -f "$1" ]] && { sum=0; unset a i; while read line; do data=($(echo $line)); for i in ${data[@]}; do for a in ${data[@]}; do [[ $i != $a ]] && { [[ $(( $i % $a )) == 0 ]] && let sum=sum+$(( $i / $a )); }; done; done; done < "$1"; echo $sum; } || echo -e "usage: $(basename "$0") [datafile]\n\twhere [datafile] is a file. with data."



#!/bin/bash
# check valid input stuff
[[ -f "$1" ]] && datafile="$1" || { echo -en "error:\tincorrect input\nusage:\t$(basename "$0") [FILE]\n\twhere [FILE] is the file with file stuff in it"; kill -INT $$; }

unset line; sum=0; res=0;
# first, run the data through sed, match regex according to:
# 1. 's/\!.//g': look for a '!' and the very next character, no matter what. remove those two characters
# 2. 's/<[^>]*>//g': in what left, look for a '<' and match everything from that, no matter what it is, until the first '>', and remove everything.
# 3. 's/[^{}]//g': from what's left, match everything that's not '{' or '}', and remove it.
# then pipe the result through 'fold' to get a 1-character-with stream to process,
sed "s/\!.//g; s/<[^>]*>//g; s/[^{}]//g" < $datafile | fold -1 | \
	{ while read line; do
	# while looping through the input we'll look for a '{'
	# and if we see one, we'll add 1 to $sum and add $sum to $res
	[[ $line = "{" ]] && { (( ++sum )); (( res+=sum )); } || (( --sum ));
	# and if we didn't we'll substract 1 from $sum and start over
	done; 
echo "the total score for ALL the groups is $res"; }

# note to self: learn this stuff with subshells and everything. this time I had to put the loop
# inside '{}' to be able to echo the result, otherwise $res was 0 if echoed outside the loop.
# just have to learn it goddammit!
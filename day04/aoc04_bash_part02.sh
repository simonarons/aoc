#!/bin/bash
# oh this one is bad. 
#
# firstly, let's see if a file is passed as an argument. otherwise we'll be angry and kill ourselves.
[[ -f "$1" ]] && datafile="$1" || {
	echo -en "error: no real file specified.\nusage: $(basename "$0") [FILE]\n\nnow i'll kill myself.\n\tfarewell";
	kill -INT $$; }
# set/reset sum, and bash built-in 'SECONDS' to 0, so we can count
sum=0; SECONDS=0;
# while we're reading the line, well do
while read line; do
	# insert the $line into an array instead of a string
	psw=($line);
	# here's the beauty:
	# if the number of elements in the array is the same as the number of elements left, counted as line, after following:
	# loop through each elemen in the current array, pipe it through 'grep' to output every character, but one line per character, 
	# sort the characters, pipe them through md5sum which returns an md5 sum per line - from which we cut the last '-' part of,
	# pipe it through 'sort', which with the '-u' switch returns only unique lines, which we count by piping them through 'wc -l'
	# and if the number of lines is the same as elements in the array, the password is OK, i.e. no words can be rearranged to an
	# identical word in the password.
	(( ${#psw[@]} == $(for i in ${psw[@]}; do grep -o . <<<$i|sort|md5sum|cut -f1 -d' '; done|sort -u|wc -l) )) && let sum=sum+1;
	#
	# and that my friends, take 7 seconds with my i7-i4790. efficient? hell, yes!
done < $datafile
# and the winner is...
echo "result: $sum (in $SECONDS sec)"

# one-liner:ish (yes, I know it's not really a one-liner, but still...)
# datafile=datafile.day04; sum=0; SECONDS=0; while read line; do psw=($line); (( ${#psw[@]} == $(for i in ${psw[@]}; do grep -o . <<<$i|sort|md5sum|cut -f1 -d' '; done|sort -u|wc -l) )) && let sum=sum+1; done < $datafile; echo "result: $sum (in $SECONDS sec)"

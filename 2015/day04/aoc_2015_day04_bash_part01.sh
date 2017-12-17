#!/bin/bash

# if no argument is passed, then data is hardcoded, otherwise take the argument as data
[[ -z $1 ]] && data="yzbqklnj" || data = "$1"

# just for formatting time from seconds a bit nicely
timefineprint() { ((h="${1}"/3600)); ((m=("${1}"%3600)/60)); ((s="${1}"%60)); printf "%02d:%02d:%02d\n" $h $m $s; }

# $SECONDS is a bash built-in that counts... seconds! so setting it to 0 we'll get the number of seconds later on
c=1; SECONDS=0
echo "starting run..."

while true; do
	# nothing fancy. cut the first 5 chars of md5sum of the input data + the counter, store it as $hash
	hash="$(echo -n ${data}${c}|md5sum|head -c5)"
	# compare if $hash is 00000, and if so break loop, otherwise check if it's the 25000th iteration, and if so, echo status, otherwise carry on and keep cool
	[[ $hash = "00000" ]] && { echo "result: $c added to $data is 00000 ($(timefineprint $SECONDS))"; break; } || { (( c % 25000 == 0 )) && { echo -e "hash nr $c\t -> $hash ($(timefineprint $SECONDS))"; }; }
	(( ++c ))
done

# jeez, that took some time... this is my output:
#time ./aoc_2015_day04_bash_part01.sh
#starting run...
#hash nr 25000    -> 1b074 (00:00:28)
#hash nr 50000    -> c3c96 (00:00:56)
#hash nr 75000    -> 156fb (00:01:24)
#hash nr 100000   -> 2a0a3 (00:01:51)
#hash nr 125000   -> dce2a (00:02:19)
#hash nr 150000   -> 89b90 (00:02:47)
#hash nr 175000   -> 72888 (00:03:15)
#hash nr 200000   -> 3e239 (00:03:44)
#hash nr 225000   -> 2efd4 (00:04:12)
#hash nr 250000   -> f0d36 (00:04:40)
#hash nr 275000   -> 65c49 (00:05:07)
#result: 282749 added to yzbqklnj is 00000 (00:05:16)
#
#real    5m15.663s
#user    7m31.626s
#sys     1m5.252s


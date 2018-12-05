#!/bin/bash
[[ $1 ]] && [[ -f $1 ]] && {
	data=$(cat $1);
} || {
	echo "error: no input file specified"; exit 1;
}
#
# Well... 
#
# This task took me on a journey. A journey I didn't ask to take, and a journey I didn't want to take; a journey that
# led me through feelings of despair, humiliation, self-deprecation and a lot of other feelings previously unbeknownst to me.  
#
# My first approach was genius. It was simple, efficient, smart, optimized and had all qualifications to be the best
# solution I've ever created – maybe even the best solution in the world, regardless of task. I simply had to loop
# through the string with bash's own processing power, comparing each character with the next and see if it was the same,
# if it was the same but in uppercase, if it was the same in lowercase, and ... Ah, fuck it. It sucked, it worked when 
# using some examples, but when I tried with the real input, it never finished. It ran and ran, but it couldn't get far enough.
# It tried – oh believe me, it tried. But alas, to no avail. Some say the code is still running to this day, but that's
# just stupid because it's my code, on my computer, and it's not running. Why would anyone say that? That's ... that's just strange.
#
# So I went for more of a brute-force thing. No comparing, nothing advanced, just some regular small-town bash programmer stuff. Here's how:
#
# 1. Generate the characters A-Z
# 2. Loop through the string and look for A-Z followed by a lowercase a-z, i.e. Aa, Ab, Ac ... Za, Zb and so on. 
# 3. This step is kinda step 2|rev.
# 4. And then count the length of the string and do these loops while the length of the string is not the same
#    as when we counted it the last time, because if so then there was nothing to replace and thusly it's all over. 
# 5. Pack up, go home, and cry.
# 6. ???
# 7. Profit.
#
# And without further ado:

unset newlen
currlen=${#data}
start=$(date +%s.%N);
echo -en "Hey, ho, let's go!\nComputing..."
while [[ $currlen != $newlen ]]; do
	currlen=${#data}
	for char in {A..Z}; do
		data=${data//$char${char,,}}
		data=${data//${char,,}$char}
	done
	echo -n "."
	newlen=${#data}
done
echo "done!"

printf "Result: $(tput setaf 46)%d$(tput sgr0) units, and it was all calculated at a blazing speed – ridiculously fast, even: It only took $(tput setaf 255)%ss$(tput sgr0)!\n" $newlen "$(awk '{printf "%.5f", $2 - $1}' <<< "$start $(date +%s.%N)")"



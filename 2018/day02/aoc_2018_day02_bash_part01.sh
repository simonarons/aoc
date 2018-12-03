#!/bin/bash
# Check if an argument is given, and that that argument is a file, and then cat it straight up in the RAM. Otherwise exit.
[[ $1 ]] && [[ -f $1 ]] && input=( $(cat "$1") ) || { echo "error: you must specify a data file."; exit 0; }

# One variable for twos, one for threes.
nr2=0; nr3=0

# Let's time this son of a gun just to prove how much better bash is on being slower than everything else.
start=$(date +%s.%N);

# Loop through EVERYTHIIING.
for id in ${input[@]}; do
    # And for each iteration, check for twos and threes
    for n in 2 3; do
        # Oh how I love bash! First we fold the current line so there's only 1 character per line.
        # Then we sort the lines.
        # Then we count every occurence with uniq.
        # Then we let grep count the number of 2s and 3s in the output, but quietly
        # and if it finds a 2 or 3, it adds 1 to the variable nr2 or nr3, or both.
        (fold -w1|sort|uniq -c|grep -qc $n) <<< $id && let nr${n}++
    done
done

# Then we print the results.

printf "$(tput sgr0)Result: Number of twos: %d, threes: %d, checksum: $(tput setaf 46)%d$(tput sgr0), and it took merely $(tput setaf 255)%s$(tput sgr0)\n" \
	$nr2 $nr3 "$(( nr2 * nr3 ))" "$(awk '{printf "%.3f seconds!\n", $2 - $1}' <<< "$start $(date +%s.%N)";)"

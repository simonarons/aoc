#!/bin/bash
# Check if an argument is given, and that that argument is a file, and then cat it straight up in the RAM. Otherwise exit.
[[ $1 ]] && [[ -f $1 ]] && input=( $(cat "$1") ) || { echo "error: you must specify a data file."; exit 0; }

# One variable for twos, one for threes.
nr2=0; nr3=0

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
echo "twos: $nr2, threes: $nr3, checksum $(( nr2 * nr3 ))"

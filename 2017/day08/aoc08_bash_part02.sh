#!/bin/bash
# Advent of Code - Day 08, Part 1 - mental sanity status: decreasing.

# A
if [[ ! -f "$1" ]]; then
	echo -en "error: input file not detected\nusage: $(basename "$0") [FILE]"
	kill -INT $$
fi

datafile="datafile.day08"
unset register data reg reg_compare reg_modify modifier value compop comp_value
declare -A register;
while read line; do register["$line"]=0; done <<< "$(cut -f1 -d' ' $datafile|sort -u)"
while read line; do
unset data
data=( $line )
reg_modify=${data[0]}
modifier=${data[1]}
value=${data[2]}
reg_compare=${data[4]}
compop=${data[5]}
comp_value=${data[6]}
modifier=${modifier/inc/+}; modifier=${modifier/dec/-}
(( ${register[$reg_compare]} ${compop} ${comp_value} )) && register[$reg_modify]=$(( ${register[$reg_modify]} $modifier $value ));
done < $datafile; printf " %-7s%8s\n%s\n" "reg." "val." "-----------------"; for reg in "${!register[@]}"; do printf " %-7s%8s\n" $reg ${register[$reg]}; done|sort -n --key=2; printf "%s\n" "-----------------"

#for reg in "${!register[@]}"; do printf "%-3s%10s\n" $reg ${register[$reg]}; done|sort -n --key=2




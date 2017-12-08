#!/bin/bash
# Advent of Code - Day 08, Part 1 - mental sanity status: decreasing.

# A
if [[ ! -f "$1" ]]; then
	echo -en "error: input file not detected\nusage: $(basename "$0") [FILE]"
	kill -INT $$
fi

datafile="datafile.day08"
unset register data reg reg_compare reg_modify modifier value compop comp_value
# let's declare an associative array called register, 
declare -A register;
# fill that array with each "register" from the datafile, and set starting value 0
# here we take the datafile, cut first field (delimited by space), and sort it
# uniquely to avoid non-unique stuff
while read line; do register["$line"]=0; done <<< "$(cut -f1 -d' ' $datafile|sort -u)"
# now process the datafile 
while read line; do
unset data
# let each line convert smoothly to an array
data=( $line )

# the datafile layout looks like this:
#
# g	dec	231	if	bfx	>	-10
#
# which means "decrease register g with 231 if register bfx is greater than -10"
# so, let's assign
# "reg_modify"	= the register we will modify (g)
# "modifier"	= increase or decrease (dec)
# "value"	= how much we should increase/decrease (231)
# "reg_compare"	= the register we will compare (bfx)
# "compop"	= what comparison operator to use (greater than, '>')
# "comp_value"	= what valu to compare $reg_compare (bfx) with (-10)
reg_modify=${data[0]}; modifier=${data[1]}; value=${data[2]}; reg_compare=${data[4]}; compop=${data[5]}; comp_value=${data[6]}
# cool thing, you can do substring replacing directly in a bash variable
# so we will simply replace "inc" with a "+" and "dec" with a "-", 
# and we run the same replace twice, since only one will actually replace it
modifier=${modifier/inc/+}; modifier=${modifier/dec/-}
# and thusly, we say (let's take the line from above as example)
# if the value of register[bfx] is greater than -10 is true, then register[g] is register[g] + 231
(( ${register[$reg_compare]} ${compop} ${comp_value} )) && register[$reg_modify]=$(( ${register[$reg_modify]} $modifier $value ));
done < $datafile; 

# print it somewhat nicely
printf "\n%12s\n%s\n %-7s%8s\n%s\n" "REGISTER" "-----------------" "reg." "val." "-----------------"; for reg in "${!register[@]}"; do printf " %-7s%8s\n" $reg ${register[$reg]}; done|sort -n --key=2; printf "%s\n\n" "-----------------"





# put on one, very long, line - quite obviously just stupid: 
#datafile="datafile.day08"; unset register data reg reg_compare reg_modify modifier value compop comp_value; declare -A register; while read line; do register["$line"]=0; done <<< "$(cut -f1 -d' ' $datafile|sort -u)"; while read line; do unset data; data=( $line ); reg_modify=${data[0]}; modifier=${data[1]}; value=${data[2]}; reg_compare=${data[4]}; compop=${data[5]}; comp_value=${data[6]}; modifier=${modifier/inc/+}; modifier=${modifier/dec/-}; (( ${register[$reg_compare]} ${compop} ${comp_value} )) && register[$reg_modify]=$(( ${register[$reg_modify]} $modifier $value )); done < $datafile; printf "\n%12s\n%s\n %-7s%8s\n%s\n" "REGISTER" "-----------------" "reg." "val." "-----------------"; for reg in "${!register[@]}"; do printf " %-7s%8s\n" $reg ${register[$reg]}; done|sort -n --key=2; printf "%s\n\n" "-----------------"




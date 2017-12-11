#!/bin/bash
# okay, so this one was probably more complicated for me than it should.
# also, this has been a lot of trial and error due to the fact that I am
# a bit stupid, from time to time. anyhow:

# unset stuff, and set input. we could make the input passable as argument, but who the fuck cares.
unset data newdata select
(( pos = 0, skip = 0, xi = 0 ))
lengths=(18 1 0 161 255 137 254 252 14 95 165 33 181 168 2 188)

# create two arrays with ALL the numbers between here and 255.
for el in {0..255}; do data[$el]=$el; done
for el in {0..255}; do newdata[$el]=$el; done

# loop through the 'lengths' array and see if I remember what I've done. oh my god, what HAVE I've done
for select in ${lengths[@]}; do
	# 'xi' is pretty much the last position in the selection we're making. i.e. if we should select 'select' 
	# characters from position 'pos', then it would be 'pos + select'. the reason of this is to countdown
	# 'xi' while iterating over the array, to reverse the shit. jeez, this all feels like a very subpar solution
	# the more I think of it
	(( xi = pos + select - 1 ))
	
	# then, if select is less than 2, we won't change anything in the array anyhow, so let's just move the position
	# and rock on. and we'll also add +1 to 'skip'
	(( select < 2 )) && { (( pos += select + skip, skip++ )); continue; }
	
	# this is the -=<(CoRe LooP)>=- (tm) which starts at 'pos', counts upwards until it's at the end, which is
	# 'pos' + 'select' characters
	for (( i = pos; i < pos + select; i++ )); do
	
		# both the arrays data and newdata are the same from the very first beginning
		# but not for very long. we'll simply replace the current array value in newdata to the one from 
		# the 'data' array with an offset of 180 degrees.
		# the 'i % ${#data[@]}' means 'i mod length_of_data_array', so we don't have to stuff around with
		# minuses and pluses and everything that goes with it.
		newdata[(( i % ${#data[@]} ))]=$(( data[(( xi % ${#data[@]} ))] ))
		
		# and countdown 'xi'
		(( xi-- ))
	done
	
	# first loop done, now we'll mirror the arrays so that 'data' get's up-to-date. or should I say up-to-DATA? no. I shouldn't
	data=(${newdata[@]})
	# move position forward the length + the skip
	(( pos += select + skip ))
	# skippetydoo 1
	(( skip++ ))
done

echo "los resultos is: $(( data[0] * data[1] ))"



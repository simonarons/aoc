#!/bin/bash
# Uhmm... Okay, this was tricky. Not in a tricky way. But tricky as hell in seeming
# disturbingly more complicated than it was.
# My initial take, which I was completely sure of was wrong, was to take the whole
# datafile, clean it such as:

# cat datafile.day07 | sed -re 's/(\([0-9]*\)|[->,])//g; s,\s+, ,g'

# Which means that we take the file, pipe it through sed, remove everything that is
# digits within parenthesis, remove all commas and '->', and finally remove all but
# one space between the names. This, I thought, would really look nice in an array.
# So I created one by:

# programs=( $(cat datafile.day07 | sed -re 's/(\([0-9]*\)|[->,])//g; s,\s+, ,g') )

# That array I wanted to sort, to get the very unique little program name that should
# be the atlasesque one, who's shoulders are carrying the weight of the world. Thusly
# I would just echo the array, sort it, and only print the unique line left. Which
# would be the holy program name. And for the array to output each name on a new line,
# I would need to replace the spaces with '\n'. The result? Behold, the mighty ... meh, here:

# echo ${programs[@]} | tr ' ' '\n' | sort | uniq -u 

# And somewhere about here, a great shame came over me. When thinking what I've done,
# I realized that I've gone through a hell of a lot of hoops to arrive at a point when
# all I've done is sort a fucking list. Sure, regex and arrays and all bells and whistles.
# But still. I kind of only sorted a text file.
# Alas, the shame wouldn't bring me down! Instead, emboldened by the shame, I realized
# that it's probably the easiest problem of them all. I just thought it was waaaay too
# complicated for me.

# My solution worked, nota bene, but instead of:

# programs=( $(cat datafile.day07 | sed -re 's/(\([0-9]*\)|[->,])//g; s,\s+, ,g') ); echo ${programs[@]} | tr ' ' '\n' | sort | uniq -u 

# I could boil it down to:

# grep -Po '[a-z]+' datafile.day07 | sort | uniq -u

# That was EXACTLY the top comment on reddit for the solution thread of that day.
# And I hadn't even looked at it before solving this.

# Or, to be honest, I had different options to grep than the solution on reddit.
# The reddit one said 'grep -o -E', I had 'grep -Po'. The difference is extended
# regex vs. perl regex. The difference is also none, in this case.

# Well, that's that. fml, rofl, lol, etc.

# Oh, yeah, the script, this time a true one-liner:

[[ -f $1 ]] && { echo "the program you want is $(grep -Po '[a-z]+' <"$1" | sort | uniq -u)."; } || echo "error: gimme a input file, sucker."


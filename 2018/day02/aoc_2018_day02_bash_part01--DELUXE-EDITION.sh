#!/bin/bash
# Dear diary:
# Wow.
# Turns out you can go from 
#	./aoc_2018_day02_bash_part01.sh datafile.day02
#   Result: Number of twos: 246, threes: 24, checksum: 5904, and it took merely 1.685 seconds!
# to
#   ./aoc_2018_day02_bash_part01--DELUXE-EDITION.sh datafile.day02
#   Result: 5904 (in 0.0144844055s)
#
# (i.e. from 1.685 to 0.014 seconds)
# just by outsourcing the sorting to perl.
#
# TIL.
# ❤ xoxo ❤
#   //Simon

# Input from file, passed as argument or stdin, in that order.
while true; do
    if [[ -t 0 ]]; then
        if [[ $1 ]]; then
            if [[ -f $1 ]]; then
                input=$(cat "$1");
                break;
            else
                input="$@";
                break;
            fi
        fi
    else
        stdin=${1:--}
        while IFS= read -r line; do
            input=$line
        done < <(cat -- "${stdin}");
        break;
    fi
    echo -e "error: no input.";
    exit 1;
done

# Start the clock.
start=$(date +%s.%N);

# After reading the next line you're probably thinking "Gee, perl? Is that bash? It's not bash. Isn't that cheating? You're cheating!"
# Well, first and foremost: Why should I need to defend myself in my own comments? Huh? Where's your comeback? Huh? Yeah, that's right. Check and mate, bitch.

# This is the line:
# data=$( (perl -F -lane 'print sort @F' | tr '\n' ':' | fold -w1 | uniq -c | tr -dc '23:'|tr ':' '\n') <<< "$input" )

# Which expanded is like this:
data=$( ( # Here's a fun thing: If I were to remove the space between the parentheses to the left,
          # everything would fail because bash would interpret that as an arithmetic expansion. 
          # What's that? If I know that because I spent a considerable amount of time troubleshooting why I got the message 
          #     unexpected EOF while looking for matching `''
          # when trying to run this script? What would make you think that? 
          # Anyhoo, what happens is:
    perl -F -lane 'print sort @F' | # Using perl's built-in function to sort a string like there was no tomorrow. Turns out to be très effective.
    tr '\n' ':' | # Then we replace every line break with ":" so that everything becomes a long, smooth line separated with ":".
    fold -w1 | # And we fold it, to a 1 character wide, 6500 line long beauty...
    uniq -c | # which we count occurrences of characters in. See below for a more graphic explanation.
    tr -dc '23:' | # We then remove everything except "2", "3", and ":", 
    tr ':' '\n' # and replacing ":" with a line break.
    ) <<< "$input" ) # <- That's the input. One could suspect it from the name.

# Now we just grep the data for 2's and 3's. It works because even if there are (as in my input) 647 2's, the '-c' just count lines. And there are 246 lines with a 2 in it.
printf "Result: %d (in %ss)\n" "$(( $(grep -c 2 <<< $data) * $(grep -c 3 <<< $data) ))" "$(awk '{printf "%.10f", $2 - $1}' <<< "$start $(date +%s.%N)")"

# "Explain it like I'm the 5 year old kid of Richard Stallman!"
# Ok:
# Three first lines of an input:
# 
# jiwamotqgcfnudclzbyxkzmrvp
# jiwamotqgsfnidcvzpyxkhervp
# jiwamotqgsqnjdclzbyxkaervp
# 
# After sorted by perl, they be like
# abccdfgijklmmnopqrtuvwxyzz
# acdefghiijkmnoppqrstvvwxyz
# aabcdegijjklmnopqqrstvwxyz
#
# Line break replaced and suddenly:
# abccdfgijklmmnopqrtuvwxxyzz:acdefghiijkmnoppqrstvvwxyz:aabcdegijjklmnopqqrstvwxyz
#
# Now fold, so they become:
#
# a
# b
# c
# c
# d
# f
# [...]
# x
# y
# z
# z
# :
# a
# c
# d
# [...]
#
# And we look after number of occurrences, which will look something like this:
#      1 a
#      1 b
#      2 c
#      1 d
#      1 f
#      1 x
#      1 y
#      2 z
#      1 :
#      1 a
#      1 c
#      1 d 
#      3 d 
#
# But we only want 2's and 3's, so we remove everything except those, and except ":", because that's our artifical line break replacement.
# And we end up with something that could look similar to:
#     222:32:222:222:222::3:
# We then replace the ":" with "\n", which in the case above would like this (without the lines, they're just for clarity):
# ----
# 222
# 32
# 222
# 222
# 222
# 
# 3
# 
# ----
#
# And in this particular case, a 'grep -c 2' would give '5' (there are 5 lines with a '2'), and a 'grep -c 3' would give 2, for the same reason.
# Apply some advanced quantum physic mathematics and you get 5*3=15. 
#
# Wow, why did I write all this? 
# Seriously?
#
#
#
# (help me)
#
#




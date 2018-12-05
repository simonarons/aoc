#!/bin/bash
[[ -f $1 ]] || { echo "error: no input file, come on..."; exit 5; }
# Mental note: don't regexp when tired.
# Basically what happens is that it doesn't escape things, just replaces with the amount of characters it would have been if escaped,
# so it's just a matter of counting characters and nothing more. Fuck it, I'm going to bed.

filesize=$(wc -c < $1)
newcodesize=$( (sed 's/^"/HEJ/g; s/"$/JON/g; s/\\"/ASST/g; s/\\\\/ENDA/g; s/\\x/HL!/g'|wc -c) < $1)
echo "Result: $(( newcodesize - filesize ))"


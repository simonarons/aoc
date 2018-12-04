#!/bin/bash
#
# Part 2 is even easier, it seems. Just grep the string for a pair of letters that appears twice, but without overlapping:
#   '(..).*\1'
#
# And also for two letters repeating with one letter between them:
#   '(.).\1'
#
# Everything of course by first going to regex101.com to get it right. But that's not cheating. No it's not.
#
[[ -f $1 ]] || { echo "error: please specify a file, stupid."; exit 2; }
echo -n "Result: "
grep -P '(..).*\1' $1 | grep -P '(.).\1' | wc -l

#!/bin/bash
# Today, less is more. Well, unless you're using linux, then less is as more, only better. But in real life, less is more, more or less.
# No stdin, no cat, nothing fancy. Just let's GREP THE HELL OUT OF THIS FILE, BABY!

# Let's take an input file for an argument, it should be enough.
[[ -f $1 ]] || { echo "error: please specify a file, stupid."; exit 55123455323332; }

echo -n "Result: "

# Now grep for 
# 1. Three occurrences of a, e, i, o and u.
#grep -P '(.*[aeiou]){3}' $1 | 

# 2. At least one occurrence of a letter repeating twice in a row, and since there's only letters in the file, we can match anything (".") that occurs twice in a row.
#grep -P '(.)\1' |

# 3. And no freakin' "ab", "cd", "pq" or that pesky "xy" should never, EVER, be allowed in our string.
#grep -Pv 'ab|cd|pq|xy' | 

# 4. The result? We count it. That's how we do it in bash.
#wc -l

# But who would ever do this one multiple lines? No one, that's who. So as a true oneliner:

grep -P '(.*[aeiou]){3}' $1 | grep -P '(.)\1' | grep -Pv 'ab|cd|pq|xy' | wc -l

# Jeez. It really can't get any faster than this.
#!/bin/bash
[[ -f $1 ]] || { echo "error: no input file, come on..."; exit 5; }
#
# 1. Get the character count of ze file:
filesize=$(wc -c < $1)

# 2. Strip/replace everything except the code to make it countable. Regex explained line by line as:

	# s/^\"//g;						Remove leading quotes.
	# s/\"$//g;						Remove trailing quotes.
	# s/\\x[a-f0-9][a-f0-9]/:/g;	Replace all \xYZ hex sequences with a single character (":").
	# s/\\\\/:/g;					Replace escaped backslashes with a single character.
	# s/\\"/:/g						Replace escaped quotes with a single character.

# 3. ???
# 4. Profit!
#
# But we of course do this in a single sed command:

codesize=$(sed 's/^\"//g; s/\"$//g; s/\\x[a-f0-9][a-f0-9]/:/g; s/\\\\/:/g; s/\\"/:/g' < $1 | wc -c)

echo "Result: $(( filesize - codesize ))"
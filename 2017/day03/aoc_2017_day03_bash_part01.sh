#!/bin/bash
[[ -z "$1" ]] && { clear; echo -e "\n\n\n\tHey buddy,\n\n\tYou know what? I've been pulling my hair trying to get this to work.\n\tI've succeeded, sure, and I'm very, very proud. But I'm completely\n\texhausted. I have sore eyes because I forgot to blink during the\n\tcountless hours I've spent trying to get this to work. Hell, I don't\n\teven know what I've done. But a combination of Excel, internet,\n\tmiddle-school-grade mathematic understanding, a great Spotify\n\tplaylist and lack of social life led me here. I'm done with this\n\tpart of the problem, and I won't even look at part 2. At least not now.\n\tBecause I'm fucking tired. So the mere fact that you just omit input\n\tto this script, it... it... it just baffles me. How do you even have\n\tthe nerve to just \"let's see what happens if I run this, rofl idk lol\"?\n\tYou know what, if you don't have the common courtesy to enter some\n\tinput, you're not worthy of using this script. And thus, it'll exit now.\n\n\tNah, just kidding.\n\n\n\tusage: $(basename "$0") [INPUT] (like digits for example)\n\n"; kill -INT $$; } || { [[ -f "$1" ]] && data=$(<$1) || data="$1"; }

	# setting $data from user input, and reset some stuff
	level=1; tot=1;
	# hey ho, let's go. while our square $tot (as in total) is less than our actual number $data, let's loop the shit out of this:
		while [[ $tot -lt $data ]]; do
			# start from level 1 odd it upp and commence the strive towards...
			let level=$(( level + 2 ));
			# ... the highest square number we can find that is greater than $data, but still juuust as close as possible.
			let tot=$(( level * level ));
		# oh... huh. I thought this would be a much loopier loop, but apparently not.
		done;
		# and now, some high-level math:
		# stuff
		let offset=$(( tot - data ));
		# stuff with a %-sign in it. it looks very professional, if I may say so
		let steps=$(( offset % (level - 1) ));
		# and the result, calculated with the speed of lightning, presents itself to the user who now is free to take what action he or she might be willing to take for thiafniodasfnoakdsmf I'm so tired. sorry, night.
			# note to self: a negative input is not taken care of. fix. lol. as if i would.
		let result=$(( (level - 1) / 2 + (level / 2) - steps ));
	echo -e "BAM: result: $result"

# and a one-liner-kind-of:
# data="347991"; level=1; tot=1; while [[ $tot -lt $data ]]; do let level=$(( level + 2 )); let tot=$(( level * level )); done; let offset=$(( tot - data )); let steps=$(( offset % (level - 1) )); let result=$(( (level - 1) / 2 + (level / 2) - steps )); echo $result

#!/bin/bash
# Official declaration of the array that henceforth shalt be known as "corrections", which will contain the - you guessed it - corrections!
declare -a corrections
# I'm just going to loop through everything as I did in part 1, more or less, with some changes though.
while true; do
    if [[ -t 0 ]]; then
        if [[ $1 ]]; then
			if [[ -f $1 ]]; then
				# Hey, look, no array!
				corrections=$(cat "$1");
				break;
			else
				# No array here either, in fact we just take the arguments from the command line and replace the ' ' with '\n'. 
				corrections="$(tr ' ' '\n' <<< $@)";
				break;
			fi
		fi
    else
		stdin=${1:--}
        while IFS= read -r line; do
			# Neither this is an array, lo and behold.
			corrections=$(printf "%s\n%s\n" $corrections $line)
        done < <(cat -- "${stdin}");
		break;
    fi
	echo -e "error: no input.";
	exit 1;
done

# Here we go:

# What's the Frequency, Kenneth? Well let me tell ya:
frequency=0

# And now for the smart part: We define an associative array
declare -A frequencies

# Let's set zero this motherfunking array and fire up this loop before it's too late!
frequencies[$frequency]=0

# Just stylin' is all.
printf "\n\n%s" "$(tput setaf 196)= $(tput setaf 255)start loop$(tput setaf 196) "; printf "%-*s" $(($(tput cols)-14)) | tr ' ' '='; printf "$(tput sgr0)";

loop_iteration=1; total_iteration=1; # On your marks...
startloop=$(date +%s.%N) # Get set... the start time for the loop.

while true; do # GO... No, BASH!
	[[ $(( loop_iteration % 5 )) == 0 ]] && { # For every 5 loops, print some stats.
		start=$(date +%s.%N);
		printf "\n        loop $(tput setaf 255)%3d$(tput sgr0), iteration $(tput setaf 255)%7d$(tput sgr0) " $loop_iteration $total_iteration;
		} 

	while read -r correction; do # Read all the frequency corrections.
		frequency=$(( frequency + correction )) # Set current frequency according to correction correctly.
		
		# This is the money shot, though: We simply look at the associative array and look if the current frequency exists, because if it does, then that's a solid win for this script.
		[[ ${frequencies[$frequency]} ]] && {
			printf "$(tput setaf 10) FOUND IT$(tput sgr0) - First frequency reached twice is $(tput setaf 15)%s$(tput sgr0) " $frequency; # Happy printout is happy.
			awk '{printf "(total time %.1fs)\n", $1-$2}' <(date +"%s.%N $startloop") # Nice awk time formatting, eh?
			break 2;
			}

		# But if the array doesn't have the current frequency, we set it.
		frequencies[$frequency]="$correction"
	
	let total_iteration++ # Moar iterations.
	done <<< "$corrections"
	
	[[ $(( loop_iteration % 5 )) == 0 ]] && { # This is where the every 5th iteration prints out the time the iteration took.
		# awk '{printf "%.3fs\n", $2 - $1}' <<< "$start $(date +%s.%N)";
		awk '{printf "%.3fs", $2 - $1}' <<< "$start $(date +%s.%N)";
		}
	let loop_iteration++
done # Done.

printf "$(tput setaf 46)%-*s" $(($(tput cols)-15)) | tr ' ' '='; printf "$(tput sgr0)"; printf "%s\n\n\n" " $(tput setaf 255)stop loop $(tput setaf 46)==="; # Some bells and whistles.


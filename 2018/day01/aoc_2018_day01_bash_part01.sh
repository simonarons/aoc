#!/bin/bash
unset corrections correction frequency stdin
# I hereby declare the array "corrections"!
declare -a corrections
while true; do
	# Is the input coming from the terminal?
    if [[ -t 0 ]]; then
		# Well then is there input at all?
        if [[ $1 ]]; then
			# Ok, but is it a file then? Come on, work with me here.
			if [[ -f $1 ]]; then
				# Ok, great, then I just cat it to the array and break the loop.
				source="$1" # Just setting name of the source.
				corrections=( $(cat "$1") );
				break;
			else
				# No file? Ok, then let's assume it's just a lot of digits and pluses and minuses provided as arguments.
				source="command line"
				corrections=( $@ );
				break;
			fi
		fi
    else
		# Ok so there were no arguments passed, and thus, no file - let's try stdin, baby!
        source="stdin"
		stdin=${1:--}
        while IFS= read -r line; do
            corrections+=( ${line} )
        done < <(cat -- "${stdin}");
        break;
    fi
	# If you can read this, then no arguments, no file or no stdin was detected, abort, abort, abort!
	echo -e "$(tput sgr0)$(tput setaf 7)$(basename "$0"): $(tput setaf 9)error:$(tput setaf 7) no file or data specified.\nusage:\t$(basename "$0") <file|data|stdin>\n\n\t(What, stdin? Yep, I can handle stdin. How do you like them apples?)$(tput sgr0)";
	exit 1;
done

# Yey, we've come so far that we're going to start doing some hardcore math.
# Loop through the array.
for correction in "${corrections[@]}"; do
	# Just a small check if the current object is a fine mixture of the digits '0-9', allowing a preceding '+' or '-', of course.
	if [[ ${correction} =~ ^(\+|-)?[0-9]+$ ]]; then 
		frequency=$(( frequency + correction ));
	else
		# And if the input isn't as expected, let's abort and play stupid.
		echo -e "$(tput sgr0)$(tput setaf 7)\n\tHuh... So, here I am, trying to calculate all the corrections to the frequency, when suddenly this value appears:\n\n\t\t'$(tput setaf 15)${correction}$(tput setaf 7)'\n\n\tNow, I don't know what to do with that. I can't calculate it. And thus, I will cancel everything and abort this whole damn operation. Sorry.\n$(tput sgr0)"
		exit 1;
	fi
done

# We've reached the finish line. The audience is cheering and we just have to print out the result. So let's keep them on the edge...This part is SO unnecessary, and I even had to tell a friend I'm meeting that I'm running late. What's wrong with me? I need help.
export i=0 # Just for shellcheck to be satisfied.
echo -e "$(tput sgr0)$(tput setaf 15)\n\n\tFrequency Correction Calculator-o-matic 2000$(tput sgr0)"
echo -n "$(tput setaf 10)"; printf "\t%-*s\n" $(( $(tput cols) / 2 ))|tr ' ' =; echo -n "$(tput sgr0)";
echo -ne "\tReading data from $(tput setaf 15)${source}$(tput sgr0)"; for i in {1..20}; do echo -n "."; sleep 0.00${RANDOM}; done; echo "$(tput setaf 10)OK$(tput sgr0)";
echo -ne "\tAccessing neural AI network"; for i in {1..40}; do echo -n "."; sleep 0.0${RANDOM}; done; echo "$(tput setaf 10)OK$(tput sgr0)";
echo -ne "\tCalculating data"; i=0; for i in {1..70}; do echo -n "."; sleep 0.0${RANDOM}; done; echo "$(tput setaf 10)OK$(tput sgr0)";
echo -ne "\tRetrieving result"; for i in {1..5}; do echo -n "."; sleep 0.${RANDOM}; done; echo "$(tput setaf 10)OK$(tput sgr0)"; 
sleep 1.5

# This is the only line that's actually useful.
echo -en "$(tput sgr0)$(tput setaf 7)\n\tCalculation completed... Processed $(tput setaf 15)${#corrections[@]}$(tput setaf 7) corrections.\n\t\tThe final frequency is"; for i in {1..4}; do echo -n "."; sleep .${RANDOM}; done; echo -e " $(tput setaf 15)${frequency}$(tput sgr0)\n";
sleep 1
echo -ne "\tReleasing neural AI network"; for i in {1..50}; do echo -n "."; sleep 0.00${RANDOM}; done; echo -e "$(tput setaf 10)OK$(tput sgr0)\n"
sleep 1

# Booya.
exit 0;
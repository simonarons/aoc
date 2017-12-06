#!/bin/bash
digits="$1"
[[ $digits =~ ^[0-9]+$ ]] && { sum=0; pos=0; while [[ $pos -lt ${#digits} ]]; do [[ $pos -lt $((${#digits}/2)) ]] && { [[ ${digits:$pos:1} == ${digits:$(($pos+${#digits}/2)):1} ]] && let sum=sum+${digits:$pos:1}; } || { [[ ${digits:$pos:1} == ${digits:$(($pos-${#digits}/2)):1} ]] && let sum=sum+${digits:$pos:1}; }; let pos++; done; echo "motherfunking bash result: $sum"; } || echo -e "that's no digits, stupid. only digits."

#!/bin/bash
[[ -f "$1" ]] && { datafile="$1"; sum=0; while read line; do let sum=$(( sum + $(( $(echo $line|sed 's/ /\n/g'|sort -n|tail -n1) - $(echo $line|sed 's/ /\n/g'|sort -n|head -n1) )) )); done < $datafile; echo "$sum"; } || echo -e "error: no such file or something\nusage: $(basename "$0") [DATAFILE]"

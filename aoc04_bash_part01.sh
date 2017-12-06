#!/bin/bash
[[ -f "$1" ]] && { datafile="$1"; sum=0; while read line; do psw=($line); [[ ${#psw[@]} == $(echo "${psw[@]}"|tr " " "\n"|sort -u|wc -l) ]] && let sum=sum+1; done < $datafile; echo "$sum"; } || echo -e "error: no such file or something\nusage: $(basename "$0") [DATAFILE]"

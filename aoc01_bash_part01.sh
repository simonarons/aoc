#!/bin/bash
digits="$1"
[[ $digits =~ ^[0-9]+$ ]] && { sum=0; pos=0; while [[ $pos -lt ${#digits} ]]; do [[ ${digits:$pos:1} == ${digits:$pos-1:1} ]] && let sum=sum+${digits:$pos:1}; let pos++; done; echo "result: $sum"; } || echo -e "$digits is not just digits"

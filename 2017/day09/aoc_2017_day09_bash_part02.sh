#!/bin/bash
[[ -f "$1" ]] && {
cat $1 | sed -r 's/!.//g; s/[^><]*<([^>]*)>[^<]*/\1/g' | tr -d '\n' | wc -c; } || echo "no file specified"


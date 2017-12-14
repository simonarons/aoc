#!/bin/bash
(
while read a b; do
	list[${a%:}]="$b";
done
sum=0
for i in "${!list[@]}"; do
	(( ( i%( (list[i]-1)*2) )==0)) && ((sum+=i*list[i]))
done
echo $sum

 ps=0
 while true; do
 ((ps++))
 for i in "${!list[@]}"; do
 (( ( (i+ps)%( (list[i]-1)*2) )==0)) && continue 2
 done
 break
 done
 echo $ps
)<$1


#awk -F ':' '{print $1}'

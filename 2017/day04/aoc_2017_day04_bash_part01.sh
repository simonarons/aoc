#!/bin/bash
# is the argument a file? if so: hey ho, let's go!
[[ -f "$1" ]] && {
# datafile is datafile is datafile
datafile="$1";
# set/reset sum
sum=0;
# read some line (i.e. read line by line from datafile)
while read line; do
# take the line as string and put it in a array and baby you've got a stew going!
psw=($line);
# count the elements in the array, the number of words, that is, and match them
# with taking the array, printing them as separate lines, sorting them uniquely and
# counting them. if the number of lines is the same as number of words, it's a-ok!
# and we add a 1 to the sum to count how many password lines that are valid
[[ ${#psw[@]} == $(echo "${psw[@]}"|tr " " "\n"|sort -u|wc -l) ]] && let sum=sum+1;
# done-diddeli-doo
done < $datafile;
# reveal the result:
echo "$sum";
# end this very lengthy "if true then"-statement, and complain otherwise
} || echo -e "error: no such file or something\nusage: $(basename "$0") [DATAFILE]"


# sort of a oneliner:
# datafile="datafile.day04"; sum=0; while read line; do psw=($line); [[ ${#psw[@]} == $(echo "${psw[@]}"|tr " " "\n"|sort -u|wc -l) ]] && let sum=sum+1; done < $datafile; echo "$sum";
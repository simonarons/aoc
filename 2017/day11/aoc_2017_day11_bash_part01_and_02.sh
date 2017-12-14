#!/bin/bash
unset data steps max y z
# first, import datafile
data=$(<datafile.day11)
# ooh, look at all those commas, well ...
data=(${data//,/ })
# ... BAM, it's an array.

((x=y=max=0))

for s in "${data[@]}"; do
	case $s in
		n)	(( y++ )) ;;
		ne)	(( x++, y++ )) ;;
		nw)	(( x-- )) ;;
		se)	(( x++ )) ;;
		s)	(( y-- )) ;;
		sw)	(( x--, y-- )) ;;
	esac

    ((xt=x>0?x:-x,
      yt=y>0?y:-y,
      steps=(x*y)>0 ? (xt>yt?xt:yt) : xt+yt,
      max<steps && (max=steps)))
	done
echo $steps $max

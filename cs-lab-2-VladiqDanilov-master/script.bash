#!/bin/bash
x=$1
y=$2
if (($y==0))
then
	echo $(($x+$y)) $(($x-$y)) $(($x*$y)) "#"
else
	echo -e "$(($x+$y)) $(($x-$y)) $(($x*$y)) \c"
	printf "%.2f\n" "$((100*$x/$y))e-2"
fi

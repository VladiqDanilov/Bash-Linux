#!/bin/bash
export LANG=en_US.UTF-8
inputF=$1
if [[ $inputF == "" ]]
then
inputF="."
fi
lck=0
emptin=0
ReDir=0
fs=0
echo $inputF
liktree() {
	local fold=($@)
	local cntd=${#fold[@]}
	local i
	local j
	for ((i=0; i < $cntd; i++))
	do
		local ktosub=(${fold[$i]}/*)
		if [ -f ${fold[$i]} ]
		then
			fs=$(($fs + 1))
		else
			ReDir=$(($ReDir + 1))
		fi
		for ((j=0; j < $lck; j++))
		do
			printf "\u2502\u00A0\u00A0\u0020"
		done
		for ((j=0; j < $emptin; j++ ))
		do
			printf "\u0020\u0020\u0020\u0020"
		done
		if (($i == $(($cntd - 1))))
		then
			printf "\u2514\u2500\u2500\u0020${fold[$i]##*/}\n"
		else
			printf "\u251c\u2500\u2500\u0020${fold[$i]##*/}\n"
		fi
		if [[ "${ktosub[0]}" != "${fold[$i]}/*" ]]
		then
			if (($i == $(($cntd - 1))))
			then
				emptin=$(($emptin + 1))
			else
				lck=$(($lck + 1))
			fi
			liktree ${ktosub[@]}
		fi
	done
	if (($emptin > 0))
	then
		emptin=$(($emptin - 1))
	else
		lck=$(($lck - 1))
	fi
}
inputF=($inputF/*)
liktree ${inputF[@]}

printf "\n"
if (($ReDir == 1 && $fs == 1)) 
then
	echo "$ReDir directory, $fs file"
elif (($ReDir == 1 && $fs != 1)) 
then
	echo "$ReDir directory, $fs files"
elif (($ReDir != 1 && $fs == 1)) 
then
	echo "$ReDir directories, $fs file"
else
	echo "$ReDir directories, $fs files"
fi

#!/bin/bash

if [ -d $1 ]; then
	echo -e "\e[31;1mNo entered word\e[0m"
	exit 0
fi
left_border='_'

word='_'${1}'_'


working="true"
index=1
state='00'
next_state='00'
token='_'
#echo "${word:index:1}"
#echo "${word:0:$index-1}${left_border}${word:$index}"
file="/home/jesmart/MT/input.txt"
#echo "${word:index:1}"
#awk -F"," '{ print $1 }' $file
while  ! [ -z $working ]
do
	while read line
	do
		echo $word
		if [ ${#word}-2 == $index ] 
		then
			word=$s{1}'_'
		fi
		#последнюю пустую строку не обрабатываем
		if [ -z $line ]
		then
			break
		fi
		state=$(echo "$line" | awk -F"," '{ print $1 }')
		token=$(echo "$line" | awk -F"," '{ print $2 }')
		move=$(echo "$line" | awk -F"," '{ print $3 }')

		#echo $line
		#echo "next: $next_state ? state: $state"
		if [ $next_state == $state ]
		then
			#echo "token: $token ? ${word:$index-1:1}"  
			if [ $token == ${word:$index-1:1} ]	
			then
				#if[ $move == '_' && $token == '_']		
				case $move in
					'<' ) 
						if [ $index == 0 ]
						then 
							exit 0 
						else
							index=$(($index-1))
						fi;;
					'>' )
						index=$(($index+1))	;;
					* )
						word="${word:0:$index-1}${move}${word:$index}";;
				esac
			else
				#echo "true"
				continue	
				#echo "false"
			fi
			next_state=$(echo "$line" | awk -F"," '{ print $4 }')
		else
			continue
		fi
		#echo "coursor in: $index position"
		st='_'
		#echo "1:$state 2:$token 3:$move 4:$next_state"
		#условие окончания работы интерпретатора: 
		if [[ $state == $next_state && $move == $st && $token == $st ]] 
		then
		 	echo "complete: $word"
			working=''
		fi
		break
	done < $file
	
done


exit 0
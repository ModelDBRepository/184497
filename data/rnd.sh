#!/bin/bash
# rnd.sh
# list x random numbers
# Usage: rnd.sh x
# Default x is 10

if [ $1 -eq 0 ]
then
	x=10
else
	x=$1
fi

for (( i = 0 ; i < x ; i++ ))
do
	echo `od -An -N2 -i /dev/urandom`
done

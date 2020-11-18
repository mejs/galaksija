#!/bin/sh
file=$1

while read number
do
echo $(($number))
done < $file

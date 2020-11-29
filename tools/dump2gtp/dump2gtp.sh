#!/bin/bash
#this script converts MAME exported Galaksija memory dumps into gtp files used to store Galaksija tapes and for use in emulators
#requires xxd to convert to hex bin
#hexdump is exported from MAME using command: "dump $filename,$startaddress (2C36),$programlength(in hex),1 (byte grouping),0 (no ASCII interpretation)"
D2B=({0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}) #for binary conversion
dump=$1 #grabs the file
temp=/tmp/temp.hex
temp_chksum=/tmp/temp.chksum
temp_chksum2=/tmp/temp.chksum2
output=/tmp/output
name=`echo "$1" | cut -d'.' -f1` #removes file extension for name
gtp="$name.gtp" #defines output file name
hexname=`echo -n $name | od -A n -t x1` #converts file name to hex
namelength=${#name} #calculates length of name
length=$(($namelength +1)) #adds 1 to length of name
a='10' #first byte of gtp
b="$(printf '%02x\n' $length)" #file name length (+1) in hex. Second byte (b) is number of letters in name +1
sed 's/^.....//' $dump > $temp #removes addresses from MAME generated dump because they mess with xxd
cassettelength=`cat $temp | tr -d '\040\011\012\015'` #remove spaces to calculate length
cassettelength2=${#cassettelength}
cassettelength3=`expr $cassettelength2 / 2 + 7`
cassettelength4=`printf "%04X" "$((10#$cassettelength3))"`
tempextract=`cat $temp`
c='000000' #follows file name length and preceeds file name
d='0000'
f=`echo $cassettelength4 |  tac -rs .. | echo "$(tr -d '\n')"` #need to grab automatically, length of program? Program length + 7 bytes, 4 bytes total from right to left
e='0000'
g='A5362C' #follows file name and preceeds code. Not sure yet how you calculate.
h="${tempextract:8:5}" #need to grab automatically
j="FF"
chksum="${g}${h}"
echo "$chksum $(cat $temp)" > $temp_chksum
cat $temp_chksum | tr -d '\040\011\012\015' > $temp_chksum2 #removes spaces from chksum
#cat $temp_chksum2
sed -e "s/.\{2\}/&\n/g" $temp_chksum2 > $temp_chksum #newlines to chksum
sed -i -e 's/^/0x/' $temp_chksum # adding 0x to hex in prep for conversion
#cat $temp_chksum
./decimal.sh $temp_chksum > $temp_chksum2 #decimal conversion
#cat $temp_chksum2
sum=`awk '{ sum += $1 } END { print sum }' $temp_chksum2 ` #summation
#echo $sum
#expr $sum % 256 > $temp_chksum
mod=`expr $sum % 256` #calculate modulo 256
#echo $mod
binary=`echo ${D2B[$mod]}` #convert to binary
#echo $binary
binary2=`python 2s.py $binary` #get 2s complement
#hexchksm=`printf '%02X' "$((2#$binary2))"` #convert back to hex
#hexchksm2=`expr $hexchksm - 1` # subtract 1 from hex
#hexchksm=`expr $binary2 - 1` # subtract 1 from binary
decimal1=`echo "$((2#$binary2))"`
decimal2=`expr $decimal1 - 1` #subtract 1 from decimal
echo $decimal2
hexchksm2=`printf "%x\n" $decimal2`
#hexchksm2=`printf '%02X' "$((2#$hexchksm))"` #convert back to hex
#echo $hexchksm2
#i=`printf '%02X' $hexchksm2`
i=$hexchksm2
#echo $i
gtpaddon="${a}${b}${c}${hexname}${d}${f}${e}${g}${h}`cat ${temp}`${i}${j}" #combines hex to add before dump for gtp compatibility
echo $gtpaddon | tr -d '\040\011\012\015' > $output
#echo "$gtpaddon $(cat $output)" > $output
#cat $output
xxd -r -p $output $gtp #exports dump to gtp file

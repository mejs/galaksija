#!/bin/sh
#this script converts MAME exported Galaksija memory dumps into gtp files used to store Galaksija tapes and for use in emulators
#requires xxd to convert to hex bin
#hexdump is exported from MAME using command: "dump $filename,$startaddress (e.g. 2c3a),$programlength(in hex),1 (byte grouping),0 (no ASCII interpretation)"
dump=$1 #grabs the file
gtp="$name.gtp" #defines output file name
temp=/tmp/temp.hex
name=`echo "$1" | cut -d'.' -f1` #removes file extension for name
hexname=`echo -n $name | od -A n -t x1` #converts file name to hex
namelength=${#name} #calculates length of name
length=$(($namelength +1)) #adds 1 to length of name
a='10' #first byte of gtp
b="$(printf '%x\n' $length)" #file name length (+1) in hex. Second byte (b) is number of letters in name +1
c='000000' #follows file name length and preceeds file name
d='0000fa000000a5362c292d3a2c292d' #follows file name and preceeds code. Not sure yet how you calculate.
gtpaddon="${a}${b}${c}${hexname}${d}" #combines hex to add before dump for gtp compatibility
sed 's/^.....//' $dump > $temp #removes addresses from MAME generated dump because they mess with xxd
#echo $gtpaddon
#sed -i '1i$gtpaddon' $temp
#echo "$gtpaddon\n$(cat $temp)" > $temp
#cat $temp
xxd -r -p $temp $gtp #exports dump to gtp file

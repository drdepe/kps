#!/bin/bash

function box_out() {
    input_char=$(echo "$@" | wc -c)
    line=$(for i in `seq 0 $input_char`; do printf "-"; done)
    tput bold
    line="$(tput setaf 3)${line}"
    space=${line//-/ }
    echo " ${line}"
    printf '|                        welcome to kps                       '; echo -n "$space" ; printf "%s\n" '|';
    printf '|        a script to make a persistent kali usb drive          ' ;tput setaf 4; echo -n "$@"; tput setaf 3 ; printf "%s\n" ' |';
    printf '|                       twitter:dr_depe                       '  ; echo -n "$space" ; printf "%s\n" '|';
    echo " ${line}"
    tput sgr 0
}

box_out $@

echo -e ""
echo -e ""
echo -e ""
echo -e "i want to creat persistent:-

1.usb
2.sdcard"
echo "enter a number:"

read device
#if-usb

if [ $device   -eq 1 ]
then
#pop
(
echo n # Add a new partition
echo   # First sector 
echo   
echo   
echo   # Last sector 
echo w # Write changes
) | sudo fdisk /dev/sdb

mkfs.ext3 -L persistence /dev/sdb3
e2label /dev/sdb3  persistence

echo "what do you want to call it?:"
read uname
mkdir -p /mnt/$uname
mount /dev/sdb3  /mnt/$uname
echo "/ union" > /mnt/$uname/persistence.conf
umount /dev/sdb3
fi

#i-sdcard

if [ $device   -eq 2 ]
then
#pop




(
echo n # Add a new partition
echo   # First sector (Accept default: 1)
echo   
echo   
echo   # Last sector (Accept default: varies)
echo w # Write changes
) | sudo fdisk /dev/sdc

mkfs.ext3 -L persistence /dev/sdc3
e2label /dev/sdc3  persistence

echo "what do u wann call your kali?:"
read uname
mkdir -p /mnt/$uname
mount /dev/sdc3  /mnt/$uname
echo "/ union" > /mnt/$uname/persistence.conf
umount /dev/sdc3
fi















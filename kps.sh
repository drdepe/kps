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
    echo " ${line}"
    tput sgr 0
}

box_out $@

echo -e ""
echo -e ""
echo -e ""
sudo lsblk |grep sd
echo -e ""
echo -e ""

echo "Enter the device name from above (eg: sda1 ) :"

read device

(
echo n # Add a new partition
echo   # First sector 
echo   
echo   
echo   # Last sector 
echo w # Write changes
) | sudo fdisk /dev/$device

mkfs.ext3 -L persistence /dev/$device
e2label /dev/$device  persistence

echo "what do you want to call your kali (eg:NAME)?:"
read uname
mkdir -p /mnt/$uname
mount /dev/$device  /mnt/$uname
echo "/ union" > /mnt/$uname/persistence.conf
umount /dev/$device

echo -e "all done your device will reboot now ."
echo -e ""
echo -e "remove your usb device before it boots again ."
for i in  1 2 3 4 5
do
echo "rebooting your device after $i seconds ........."
sleep 1
done 

reboot 

















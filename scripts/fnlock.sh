#!/bin/bash
# Fix the Asus dysfunctional FN key on Linux Mint. 2022-10-20;
H=fnlock_default;G=asus_wmi;L=/etc/modprobe.d/alsa-base.conf;E="\n** $G $H";F=" **\n"
if [ -f /sys/module/$G/parameters/$H ]; then
    I="INSTALLED"
    grep -q "$H=N" $L
    if [ $? -eq 0 ]; then
        echo -e "$E $I ALREADY$F"
        exit 0
    fi
    O="options $G ${H}=N"
    echo -e "#Toggle $H at boot (Y/N)\n$O\n" | sudo tee -a $L
    echo -e "\nPlease WAIT ...\n"
    sudo update-initramfs -u -k all
    echo -e "$E $I NOW$F"
    exit 0
fi
echo -e "$E NOT FOUND$F"
exit 1
#

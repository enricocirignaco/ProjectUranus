#!/bin/bash

#turn off hdmi
vcgencmd display_power 0
#kill feh processes
pkill feh
#umount HDD
sudo umount /dev/sda2

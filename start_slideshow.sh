#!/bin/bash

#mount HDD
sudo mount -t exfat /dev/sda2 /media/pi
#start slideshow
feh --recursive --randomize --fullscreen  --quiet --hide-pointer --slideshow-delay 10 "/media/pi/300GB/galery" &
#wait for slideshow to start
sleep 1
#turn on hdmi
vcgencmd display_power 1


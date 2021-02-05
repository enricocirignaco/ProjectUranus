#!/bin/bash

#mount HDD
sudo mount -t exfat /dev/sda2 /media/pi
#start slideshow
# variable DISPLAY must be defined in order for the script to work with crontab
export DISPLAY=:0.0
feh --recursive --randomize --fullscreen  --zoom fill --quiet --hide-pointer --slideshow-delay 10 "/media/pi/galery" &
#wait for slideshow to start
#sleep 1
#turn on hdmi 1
vcgencmd display_power 1


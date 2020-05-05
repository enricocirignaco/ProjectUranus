#!/bin/bash

#install feh and exfat utilities
apt install feh -y
apt install exfat-fuse -y
apt install exfat-utils -y

#disable  screensaver and energy saver
xset s 0
xset -dpms

#add cron jobs

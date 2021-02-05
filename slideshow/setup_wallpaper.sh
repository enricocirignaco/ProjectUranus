#!/bin/bash

# update system
sudo apt-get update
sudo apt-get upgrade

# install feh and exfat utilities
sudo apt install feh -y
sudo apt install exfat-fuse -y
sudo apt install exfat-utils -y

# Add following cronjobs to crontab:
# start slideshow
# end slideshow
# update system once a month
CRONJOB_START = " * * * /home/pi/Documents/mambocat/start_slideshow.sh > /dev/null 2>&1"
CRONJOB_END = " * * * /home/pi/Documents/mambocat/end_slideshow.sh > /dev/null 2>&1"
CRONJOB_UPDATE = "0 0 1 * * root (apt -y update && apt -y  upgrade) > /dev/null 2>&1"
read -p "Enter slideshow start time (hh mm): " START_TIME
read -p "Enter slideshow end time (hh mm): " END_TIME
#write out current crontab
sudo crontab -u pi -l > mycron
#echo new cron into cron file
echo "$START_TIME$CRONJOB_START" >> mycron
echo "$END_TIME$CRONJOB_END" >> mycron
echo "$CRONJOB_UPDATE" >> mycron
#install new cron file
sudo crontab -u pi mycron
rm mycron

# turn off screensaver
sudo sed -i 's/# xserver-command=X/xserver-command=X -s 0 dpms/' /etc/lightdm/lightdm.conf


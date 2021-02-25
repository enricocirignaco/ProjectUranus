# mambocat
Apache Webserver to host Mambocat.ch and Wallpaper display hosted on a Raspberry Pi 4b 3GB

## Slideshow
This program show a slideshow of images stored on an external storage device on fullscreen on the Raspberry.
The slideshow turn on and off at the desired time.

### How it works
The imager viewer [feh](https://feh.finalrewind.org/) is used to display the foto gallery.
#### Dependencies
* [feh](https://feh.finalrewind.org/)
* exfat-fuse
* exfat-utils
* [cron](https://man7.org/linux/man-pages/man8/cron.8.html)

#### Setup script
The following tasks are executed when the setup script run:
* the neeeded utilities are installed
* the needed cronjobs are added to crontab
* the system screensaver is disabled

```bash
# slideshow/setup_wallpaper.sh

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
CRONJOB_START = " * * * /home/pi/Documents/mambocat/slideshow/start_slideshow.sh > /dev/null 2>&1"
CRONJOB_END = " * * * /home/pi/Documents/mambocat/slideshow/end_slideshow.sh > /dev/null 2>&1"
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


```

#### Start script
The following tasks are executed when the start script run:
* the external storage device is mounted
* the imager viewer feh is started with a bunch of settings
* the HDMI interface is turned on with the `vcgencmd display_power 1` command

```bash
# slideshow/start_slideshow.sh

#!/bin/bash

#mount HDD
sudo mount -t exfat /dev/sda1 /media/pi
#start slideshow
# variable DISPLAY must be defined in order for the script to work with crontab
export DISPLAY=:0.0
feh --recursive --randomize --fullscreen  --zoom fill --quiet --hide-pointer --auto-rotate --slideshow-delay 10 "/media/pi/galery" &
#wait for slideshow to start
#sleep 1
#turn on hdmi 1
vcgencmd display_power 1


```

#### End script
The following tasks are executed when the end script run:
* The HDMI interface is turned off
* feh process is killed
* the external storage device is unmounted to save energy

```bash
# slideshow/end_slideshow.sh

#!/bin/bash

#turn off hdmi
vcgencmd display_power 0
#kill feh processes
pkill feh
#umount HDD
sudo umount /dev/sda1

```

#### Scheduler
In order to start and stop the slideshow at the desired time the tool [cron](https://man7.org/linux/man-pages/man8/cron.8.html) is used.
To add a Cron Task (also know as Cronjob) you need to edit the crontab file with the follow command:
`crontab -e`
Then you can add a Job like explained below.
```
# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name  command to be executed
```

The Following cronjobs are created in the setup process:
```
0 18 * * * /home/pi/Documents/mambocat/slideshow/start_slideshow.sh > /dev/null 2>&1
0 23 * * * /home/pi/Documents/mambocat/slideshow/end_slideshow.sh > /dev/null 2>&1
0 0 1 * * root (apt -y update && apt -y  upgrade) > /dev/null 2>&1
```

## Webserver

Webserver based on Apache 2. The website files are updated with RapidWeaver ‪8 over sftp

#### Dependencies
* Apache 2
* PHP
* RapidWeaver
* sftp

### Installation
Follow the official [guide](https://www.raspberrypi.org/documentation/remote-access/web-server/apache.md) from the Raspberry Foundation

### Setup
1. open port 80 and 443 for the Raspberry
2. configure RapidViewer
3. Sftp Server
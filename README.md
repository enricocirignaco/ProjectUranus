# mambocat
Apache Webserver to host Mambocat.ch and Wallpaper display hosted on a Raspberry Pi 4b 3GB

## Slideshow
This program show a slideshow of images stored on an external storage device on fullscreen on the Raspberry.
The slideshow turn on and off at the desired time.
### How to use

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

#### Start script
The following tasks are executed when the start script run:
* the external storage device is mounted
* the imager viewer feh is started with a bunch of settings
* the HDMI interface is turned on with the `vcgencmd display_power 1` command

#### End script
The following tasks are executed when the end script run:
* The HDMI interface is turned off
* feh process is killed
* the external storage device is unmounted to save energy

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
0 18 * * * /home/pi/Documents/ProjectEuropa/start_slideshow.sh > /dev/null 2>&1
0 23 * * * /home/pi/Documents/ProjectEuropa/end_slideshow.sh > /dev/null 2>&1
0 0 1 * * root (apt -y update && apt -y  upgrade) > /dev/null 2>&1
```

#### FTP Server
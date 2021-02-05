#turn off both hdmi
vcgencmd display_power 0
#turn on both hdmi
vcgencmd display_power 1

#turn off just hdmi 0
vcgencmd display_power 0 2
#turn off just hdmi 1
vcgencmd display_power 0 7

#!/bin/bash
# A post-install script to set up Ubuntu  the way I like it

# Make the dock behave like Windows
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'

# Configure Asus Xonar U3 for 48 kHz 16-bit output
rm -r ~/.pulse/
mkdir ~/.pulse/
touch ~/.pulse/daemon.conf
echo "default-sample-rate = 48000" > ~/.pulse/daemon.conf
echo "alternate-sample-rate = 48000" >> ~/.pulse/daemon.conf
echo "default-sample-format = s16le" >> ~/.pulse/daemon.conf
echo "resample-method = src-sinc-best-quality" >> ~/.pulse/daemon.conf
echo "" >> ~/.pulse/daemon.conf
echo "high-priority = yes" >> ~/.pulse/daemon.conf
echo "nice-level = -11" >> ~/.pulse/daemon.conf
echo "realtime-scheduling = no" >> ~/.pulse/daemon.conf
echo "realtime-priority = 9" >> ~/.pulse/daemon.conf
echo "rlimit-rtprio = 9" >> ~/.pulse/daemon.conf
echo "daemonize = no" >> ~/.pulse/daemon.conf

# Restart pulseaudio (wait for it to die and start again)
pulseaudio -k
sleep 1
pulseaudio -D
sleep 1

# Confirm default sampling rate
pacmd list-sinks | grep Hz

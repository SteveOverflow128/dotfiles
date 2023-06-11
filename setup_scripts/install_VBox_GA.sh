#!/bin/zsh

# install guest additions
sudo apt-get -y install build-essential
sudo apt -y install linux-headers-$(uname -r)

sudo sh -c "cd /media/$USER/VBox_GAs_* && ./VBoxLinuxAdditions.run"

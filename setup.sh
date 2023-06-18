#!/bin/bash

if [[ "$OSTYPE" != "linux-gnu"* ]]; then
   echo "💥 This script only works on linux 💥"
   exit 1
fi

source ./utils.sh

FILE_CMD="ln"
FILE_CMD_ARGS="-sf"

while getopts ":hc" OPTION; do
  case "$OPTION" in
    h )
      # help
      echo "Usage:"
      echo "    setup.sh -h              Show help"
      echo "    setup.sh -c              Copy setup files to home instead of using symbolic links"
      exit 0;
      ;;
    c )
      # use copy command instead of symlink
      FILE_CMD="cp"
      FILE_CMD_ARGS="-f"
      ;;
    \? )
      echo "Usage setup.sh [-h] [-c]"
      exit 1
      ;;
    esac
done
shift $((OPTIND -1))

echo ""
  infoMessage " "
  infoMessage "Before we can do the magic we need to"
  infoMessage "make sure you are up to date."
  infoMessage " "
echo ""

sudo dnf check-update
sudo dnf -y update

if command -v snap >/dev/null 2>&1; then
    stepComplete "Snap is installed."
else
    step "Snap is not installed. Installing"
    sudo dnf -y install snapd
    # Enable on boot and start local snap server
    sudo systemctl start snapd
    sudo systemctl enable snapd
    # Enable classic snap support
    sudo ln -s /var/lib/snapd/snap /snap
    stepComplete "Snap installed."
fi

source setup_scripts/setup_git.sh

echo ""
  infoMessage " "
  infoMessage "Install VirtualBox Guest Additions"
  infoMessage " "
echo ""

question "Do you want to install VirtualBox Guest Additions?"
echo "Press "Y" after mounting media"
read -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
#  step "Installing VirtualBox Guest Additions..."
#  source setup_scripts/install_VBox_GA.sh
#  stepComplete "VirtualBox Guest Additions installed"
  echo
else
  stepComplete "Skipping VirtualBox Guest Additions installation..."
fi


echo ""
  infoMessage " "
  infoMessage "Setting up zsh"
  infoMessage " "
echo ""

source setup_scripts/setup_zsh.sh



question "Do you want to install java and related devtools?"
read -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
  source setup_scripts/setup_java.sh
else
  stepComplete "skipping java install"
fi

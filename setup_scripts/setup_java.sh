#!/bin/zsh

source ./utils.sh

echo ""
  infoMessage " "
  infoMessage "Setting up java and developer tools"
  infoMessage " "
echo ""

# Check if openjdk17 is installed
if [ ! -f "/usr/lib/jvm/java-17-openjdk-17.0.6.0.10-3.el9.x86_64/bin/java" ]; then
  step "OpenJDK 17 is not installed. Installing now..."
  sudo dnf -y install java-17-openjdk
else
  stepComplete "OpenJDK 17 is already installed."
fi

if [ -f "/opt/eclipse/eclipse" ]; then
  stepComplete "Eclipse is already installed."
else
  step "Installing eclipse..."
  pushd /tmp
  wget https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2023-06/R/eclipse-java-2023-06-R-linux-gtk-x86_64.tar.gz&mirror_id=1281
  tar xvfz eclipse-java-2023-06-R-linux-gtk-x86_64.tar.gz
  sudo mv eclipse /opt/
  popd
  stepComplete "Eclipse installed."
fi

if snap list | grep -q "postman"; then
  step "Postman is already installed. Updating..."
  sudo snap refresh postman
else
  step "Installing postman..."
  sudo snap install postman
fi

if snap list | grep -q "gradle"; then
  step "Gradle is already installed. Updating..."
  sudo snap refresh gradle
else
  step "Installing gradle..."
  sudo snap install --classic gradle
fi

resetColors


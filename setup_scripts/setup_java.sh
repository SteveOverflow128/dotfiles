#!/bin/zsh

source ./utils.sh

echo ""
  infoMessage " "
  infoMessage "Setting up java and developer tools"
  infoMessage " "
echo ""

# Check if openjdk17 is installed
if [ ! -f "/usr/lib/jvm/java-17-openjdk-amd64/bin/java" ]; then
  step "OpenJDK 17 is not installed. Installing now..."
  sudo apt -y install openjdk-17-jdk
else
  stepComplete "OpenJDK 17 is already installed."
fi

if snap list | grep -q "eclipse"; then
  step "Eclipse is already installed. Updating..."
  sudo snap refresh eclipse
else
  step "Installing eclipse..."
  sudo snap install --classic eclipse
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


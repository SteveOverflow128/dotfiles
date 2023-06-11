#!/bin/bash

# Scripts color palette
resetColor="\033[0m"
infoBackground="\033[44m\033[97m"
errorBackground="\033[41m\033[97m"
warningBackground="\033[44m\033[97m"
arrow="\033[33m❯ $resetColor"
red='\033[0;31m'
dim="\033[2m"
bold="\033[1m"
dot="\033[90m• $resetColor"
tick="\033[32m✔ $resetColor"

COLUMNS=60

# Displays a banner that justifies text within the width of $COLUMNS
infoMessage() {
  begin=$(((${#1}+$COLUMNS)/2))
  end=$(($begin-$COLUMNS))
  printf "${infoBackground}%*s${resetColor}" $begin "${1}"
  printf "${infoBackground}%*s${resetColor}\n" $end " "
}

errorMessage() {
  printf "${errorBackground} 💀 ERROR ${resetColor} %s\n" "${1}"
}

warningMessage() {
  printf "${warningBackground} ⚡ WARNING ${resetColor} %s\n" "${1}"
}

question() {
  echo -e "$arrow$@ $bold"
}

statement() {
  echo -e "$arrow$@ $bold"
}

step() {
  echo -e "$dot$@ $bold ${resetColor}"
}

stepComplete() {
  echo -e "$tick$@ $bold ${resetColor}"
}

resetColors() {
  echo -en "${resetColor}"
}

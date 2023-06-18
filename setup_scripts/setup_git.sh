#!/bin/zsh

source ./utils.sh

echo ""
  infoMessage " "
  infoMessage "Setting up git"
  infoMessage " "
echo ""

# Check if git is installed
if ! command -v git >/dev/null 2>&1; then
  step "Git is not installed. Installing now..."
  sudo dnf install -y git 
else
  stepComplete "Git is already installed."
fi

name=$(git config --global --includes user.name)
email=$(git config --global --includes user.email)

if [ ! -z "$name" ]; then
  stepComplete "Git name configured as $name"
else
  question "What is your github name?"
  read name
  git config --global user.name "${name}"
fi


if [ ! -z "$email" ]; then
  stepComplete "Git email configured as $email"
else
  question "What is your github email?"
  read email
  git config --global user.email "${email}"
fi
step "setting vi as the default git editor"
git config --global core.editor "vi"
git config --global core.excludesFile "$HOME/.gitignore_global"

# populate gitignore_global
# https://github.com/direnv/direnv/wiki/Git
cat <<EXCL >> ~/.gitignore_global
# Editor files #
################
*~
*.swp
*.swo

# Eclipse files #
#################
.project
EXCL

if ! command -v xclip >/dev/null 2>&1; then
  step "xclip is not installed. Installing now..."
  sudo dnf -y install xclip
else
  stepComplete "xclip is already installed"
fi

# Check if the SSH keys already exist
if [ ! -f "$HOME/.ssh/id_rsa" ]; then
    # Generate the SSH keys
    step "Generating SSH keys..."
    ssh-keygen -t rsa -b 4096 -C "$email" -f ~/.ssh/id_rsa -N ""
else
    stepComplete "SSH keys already exist"
fi

# Add SSH key to the ssh-agent
step "Adding ssh key into ssh-agent"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

echo
question "Do you want to register your ssh key with github?"
read -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
  step "Opening browser to register ssh keys"
  # Open the GitHub settings page to add SSH key
  if xdg-open https://github.com/settings/ssh/new &> /dev/null; then
    echo "Web page has been opened successfully!"
  else
    echo "Something went wrong while trying to open the webpage."
  fi

  statement "Press any key to continue once you have logged into github"
  read -n 1 -s -r

  # Copy the public key to clipboard
  pub_key=$(cat ~/.ssh/id_rsa.pub)
  echo "$pub_key" | xclip -selection clipboard

  statement "Public Key copied to your clipboard. Press any key to continue"
  read -n 1 -s -r

else
  stepComplete "skipping github key registration"
fi

resetColors


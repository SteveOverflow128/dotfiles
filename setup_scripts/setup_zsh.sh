#!/bin/zsh

source ./utils.sh

echo ""
  infoMessage " "
  infoMessage "Setting up zsh"
  infoMessage " "
echo ""

step "Installing ZSH"

# Check if zsh is installed
if ! command -v zsh >/dev/null 2>&1; then
  step "Zsh is not installed. Installing now..."
  sudo apt install -y zsh
  sudo apt install -y zsh-autosuggestions
  sudo apt install -y zsh-syntax-highlighting
#  sudo apt install -y direnv
  # zsh completions is not available out of the box
  echo 'deb http://download.opensuse.org/repositories/shells:/zsh-users:/zsh-completions/xUbuntu_22.04/ /' | sudo tee /etc/apt/sources.list.d/shells:zsh-users:zsh-completions.list
  curl -fsSL https://download.opensuse.org/repositories/shells:zsh-users:zsh-completions/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_zsh-users_zsh-completions.gpg > /dev/null
  sudo apt update
  sudo apt install zsh-completions
  sudo snap install starship --edge
  stepComplete "Zsh installed"
else
  stepComplete "Zsh is already installed."
fi

echo
# Make zsh the default shell
step "Setting zsh to the default shell"
chsh -s /bin/zsh

if ! [ -d "$HOME/.oh-my-zsh" ]; then
  step "Installing Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --skip-chsh
fi
stepComplete "Oh My Zsh installed"

step "Configuring ZSH"
mv -f $HOME/.zshrc $HOME/.zshrc.oh-my-zsh
ln -fsv $(pwd)/zsh/.zshrc $HOME
ln -fsv $(pwd)/zsh/.zsh_custom $HOME

echo ""
  infoMessage " "
  infoMessage "Completed"
  infoMessage "We recommend you logout and log in to reset your environment"
  infoMessage " "
echo ""

resetColors


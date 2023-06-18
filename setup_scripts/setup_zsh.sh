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
  sudo dnf install -y zsh
#  sudo apt install -y direnv
#  sudo apt install zsh-completions
  stepComplete "Zsh installed"
else
  stepComplete "Zsh is already installed."
fi

echo
# Make zsh the default shell
step "Setting zsh to the default shell"
usermod -s /bin/zsh `whoami`

if ! [ -d "$HOME/.oh-my-zsh" ]; then
  step "Installing Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --skip-chsh
fi
stepComplete "Oh My Zsh installed"

step "Configuring ZSH links"
mv -f $HOME/.zshrc $HOME/.zshrc.oh-my-zsh
ln -fsv $(pwd)/zsh/.zshrc $HOME
ln -fsv $(pwd)/zsh/.zsh_custom $HOME

if ! [ -d "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" ]; then
  step "Setting up zsh-autosuggestions"
  cd "$HOME/.oh-my-zsh/plugins/"
  git clone https://github.com/zsh-users/zsh-autosuggestions
  stepComplete "zsh-autosuggestions installed."
else
  stepComplete "zsh-autosuggestions is already installed."
fi


if ! [ -d "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" ]; then
  step "Setting up zsh-syntax-highlighting"
  cd "$HOME/.oh-my-zsh/plugins/"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
  stepComplete "zsh-syntax-highlighting installed."
else
  stepComplete "zsh-syntax-highlighting is already installed."
fi


echo ""
  infoMessage " "
  infoMessage "Completed"
  infoMessage "We recommend you logout and log in to reset your environment"
  infoMessage " "
echo ""

resetColors


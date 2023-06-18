export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.zsh_custom
ZSH_THEME=robbyrussell
COMPLETION_WAITING_DOTS="true"
plugins=(
  git
  git-extras
  gitignore
  wd
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Adding custom oh_my_zsh plugins
if [[ -f ~/.oh_my_zsh.plugins ]]; then
  for line in "${(@f)"$(<-/.oh_my_zsh.plugins)"}"
  {
    if [[ $line != \#* ]]; then plugins+=($line); fi;
  }
fi

source $ZSH/oh-my-zsh.sh
# assume ~/dotfiles is in the correct location

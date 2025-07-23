#!/bin/bash

set -e  # Stop if any command fails

DOTFILES_DIR="$(realpath "$(dirname "$0")")"

echo "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  export RUNZSH=no
  export CHSH=no
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh already installed."
fi

ln -sf $DOTFILES_DIR/zsh/zshrc ~/.zshrc

# change shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "🔁 Changing default shell to zsh..."
  chsh -s "$(which zsh)"
fi

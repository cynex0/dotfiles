#!/bin/bash
set -euo pipefail

OS="$(uname -s)"

echo "==> Installing Homebrew (if needed)"
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Installing packages from Brewfile"
brew bundle --file=Brewfile

echo "==> Installing oh-my-zsh (if needed)"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "==> Installing zsh plugins"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ -d "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" ] || \
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ -d "$ZSH_CUSTOM/plugins/zsh-autocomplete" ] || \
  git clone https://github.com/marlonrichert/zsh-autocomplete "$ZSH_CUSTOM/plugins/zsh-autocomplete"

echo "==> Installing nvm (if needed)"
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  . "$NVM_DIR/nvm.sh"
fi
nvm install --lts

echo "==> Symlinking dotfiles with stow"
stow --adopt common
if [ "$OS" = "Darwin" ]; then
  stow --adopt macos
else
  stow --adopt linux
fi
git checkout .

if [ "$OS" = "Darwin" ]; then
  echo "==> Setting macOS defaults"
  defaults write com.apple.dock autohide -bool true
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  killall Dock
fi

echo ""
echo "Done! Open a new terminal to pick up the new shell config."

if [ "$OS" = "Darwin" ]; then
  echo ""
  echo "Manual steps:"
  echo "  - Open Karabiner-Elements and grant permissions"
  echo "  - Open AeroSpace and grant permissions"
  echo "  - Open UnnaturalScrollWheels: invert vertical scroll, disable scroll accel"
  echo "  - Install CommitMono Nerd Font: https://www.nerdfonts.com/font-downloads"
fi

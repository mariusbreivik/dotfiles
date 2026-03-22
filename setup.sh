#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
REPO_URL="https://github.com/marius/dotfiles.git"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

log() {
  echo -e "\033[1;32m$1\033[0m"
}

error() {
  echo -e "\033[1;31m$1\033[0m" >&2
}

clone_dotfiles() {
  if [ ! -d "$DOTFILES_DIR" ]; then
    log "Kloner dotfiles repo til $DOTFILES_DIR"
    git clone "$REPO_URL" "$DOTFILES_DIR"
    exec "$DOTFILES_DIR/setup.sh"
  fi
}

install_oh_my_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log "Installerer oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    log "oh-my-zsh allerede installert"
  fi
}

install_homebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    log "Installerer Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    log "Homebrew allerede installert"
  fi
}

install_sdkman() {
  if [ ! -d "$HOME/.sdkman" ]; then
    log "Installerer sdkman.io"
    curl -s "https://get.sdkman.io" | bash
  else
    log "sdkman allerede installert"
  fi
}

create_symlinks() {
  for file in .vimrc .zshrc .gitconfig; do
    log "Lager symlink til $file"
    ln -vfs "$DOTFILES_DIR/$file" "$HOME/$file"
  done
}

clone_plugin() {
  local repo=$1
  local dest=$2

  if [ ! -d "$dest" ]; then
    log "Kloner $(basename "$repo")"
    git clone "$repo" "$dest"
  else
    log "$(basename "$repo") allerede installert"
  fi
}

install_plugins() {
  clone_plugin "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  clone_plugin "https://github.com/zsh-users/zsh-autosuggestions.git" "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  clone_plugin "https://github.com/ptavares/zsh-direnv.git" "$ZSH_CUSTOM/plugins/zsh-direnv"
}

main() {
  clone_dotfiles
  install_oh_my_zsh
  install_homebrew
  install_sdkman
  create_symlinks
  install_plugins

}

main "$@"
#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
REPO_URL="https://github.com/mariusbreivik/dotfiles.git"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Colors
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
  echo -e "${GREEN}$1${NC}"
}

warn() {
  echo -e "${YELLOW}$1${NC}"
}

error() {
  echo -e "${RED}$1${NC}" >&2
}

# Error trap - shows helpful message on failure
cleanup() {
  error "Setup feilet! Sjekk feilmeldingen over."
}
trap cleanup ERR

check_dependencies() {
  local missing=()
  for cmd in git curl zsh; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      missing+=("$cmd")
    fi
  done
  if [ ${#missing[@]} -gt 0 ]; then
    error "Mangler avhengigheter: ${missing[*]}"
    error "Installer disse før du kjører setup.sh"
    exit 1
  fi
  log "Avhengigheter OK (git, curl, zsh)"
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
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
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

  # Add Homebrew to PATH for current session
  if [[ -d "/opt/homebrew/bin" ]]; then
    # Apple Silicon (M1/M2/M3)
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -d "/usr/local/Homebrew" ]]; then
    # Intel Mac
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

install_sdkman() {
  if [ ! -d "$HOME/.sdkman" ]; then
    log "Installerer sdkman.io"
    # Use zsh to run installer - avoids Bash 4+ requirement on macOS
    curl -fsSL "https://get.sdkman.io" | zsh
  else
    log "sdkman allerede installert"
  fi
}

backup_dotfiles() {
  local backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
  local needs_backup=false

  for file in .vimrc .zshrc .gitconfig; do
    if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
      needs_backup=true
      break
    fi
  done

  if $needs_backup; then
    mkdir -p "$backup_dir"
    for file in .vimrc .zshrc .gitconfig; do
      if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        warn "Tar backup av $file til $backup_dir/"
        mv "$HOME/$file" "$backup_dir/"
      fi
    done
    log "Backup fullført: $backup_dir"
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
  # Ensure ZSH_CUSTOM plugins directory exists
  mkdir -p "$ZSH_CUSTOM/plugins"

  clone_plugin "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  clone_plugin "https://github.com/zsh-users/zsh-autosuggestions.git" "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  clone_plugin "https://github.com/ptavares/zsh-direnv.git" "$ZSH_CUSTOM/plugins/zsh-direnv"
}

main() {
  log "Starter dotfiles setup..."
  echo ""

  check_dependencies
  clone_dotfiles
  install_homebrew
  install_oh_my_zsh
  install_sdkman
  backup_dotfiles
  create_symlinks
  install_plugins

  echo ""
  log "Setup fullført!"
  log "Start en ny terminal for å aktivere endringene."
}

main "$@"

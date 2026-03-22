# dotfiles

Personal configuration files for macOS/Linux development environment.

## Installation

Run this one-liner to install:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/marius/dotfiles/main/setup.sh)"
```

This will:
1. Clone this repo to `~/dotfiles`
2. Install Oh-My-Zsh, Homebrew, and SDKMAN
3. Create symlinks for `.zshrc`, `.vimrc`, and `.gitconfig`
4. Install Zsh plugins (syntax-highlighting, autosuggestions, direnv)

## What's Included

- **`.zshrc`** - Zsh configuration with Oh-My-Zsh, plugins, and aliases
- **`.vimrc`** - Vim editor settings
- **`.gitconfig`** - Git configuration

## Updating

```bash
cd ~/dotfiles && git pull
```

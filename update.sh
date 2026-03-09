#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

printf "\033[1;34m[INFO]\033[0m  Pulling latest dotfiles...\n"
cd "$DOTFILES_DIR"
git pull --rebase

printf "\033[1;34m[INFO]\033[0m  Updating oh-my-zsh...\n"
env ZSH="$HOME/.oh-my-zsh" zsh -c 'source $ZSH/oh-my-zsh.sh && omz update' 2>/dev/null || true

printf "\033[1;34m[INFO]\033[0m  Updating powerlevel10k...\n"
git -C "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" pull --rebase 2>/dev/null || true

printf "\033[1;34m[INFO]\033[0m  Updating plugins...\n"
for dir in "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/*/; do
    [[ -d "$dir/.git" ]] && git -C "$dir" pull --rebase 2>/dev/null || true
done

printf "\033[1;32m[ OK ]\033[0m  Update complete. Run: exec zsh\n"

#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# ---------- helpers ----------
info()  { printf "\033[1;34m[INFO]\033[0m  %s\n" "$1"; }
warn()  { printf "\033[1;33m[WARN]\033[0m  %s\n" "$1"; }
ok()    { printf "\033[1;32m[ OK ]\033[0m  %s\n" "$1"; }
err()   { printf "\033[1;31m[ERR ]\033[0m  %s\n" "$1"; exit 1; }

is_wsl() { grep -qi microsoft /proc/version 2>/dev/null; }

# ---------- apt packages ----------
install_packages() {
    info "Installing apt packages..."
    local packages=(
        zsh
        git
        curl
        wget
        unzip
        eza
        fzf
        ripgrep
        # add more packages below
    )
    sudo apt update
    sudo apt install -y "${packages[@]}"
    ok "Packages installed"
}

# ---------- oh-my-zsh ----------
install_oh_my_zsh() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        ok "oh-my-zsh already installed"
        return
    fi
    info "Installing oh-my-zsh..."
    RUNZSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ok "oh-my-zsh installed"
}

# ---------- powerlevel10k ----------
install_p10k() {
    local dest="$ZSH_CUSTOM/themes/powerlevel10k"
    if [[ -d "$dest" ]]; then
        ok "powerlevel10k already installed"
        return
    fi
    info "Installing powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$dest"
    ok "powerlevel10k installed"
}

# ---------- zsh plugins ----------
install_zsh_plugins() {
    info "Installing zsh plugins..."

    local -A plugins=(
        [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions.git"
        [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
        [zsh-completions]="https://github.com/zsh-users/zsh-completions.git"
        # add more plugins here as [name]=url
    )

    for name in "${!plugins[@]}"; do
        local dest="$ZSH_CUSTOM/plugins/$name"
        if [[ -d "$dest" ]]; then
            ok "$name already installed"
        else
            git clone --depth=1 "${plugins[$name]}" "$dest"
            ok "$name installed"
        fi
    done
}

# ---------- nerd font reminder ----------
warn_nerd_font() {
    warn "Install a Nerd Font manually from $DOTFILES_DIR/fonts for proper shell prompts"
}

# ---------- symlinks ----------
link_dotfile() {
    local src="$1" dest="$2"
    if [[ -L "$dest" ]]; then
        rm "$dest"
    elif [[ -f "$dest" ]]; then
        mv "$dest" "${dest}.bak"
        warn "Backed up existing $dest → ${dest}.bak"
    fi
    ln -s "$src" "$dest"
    ok "Linked $dest → $src"
}

create_symlinks() {
    info "Creating symlinks..."
    link_dotfile "$DOTFILES_DIR/zsh/.zshrc"   "$HOME/.zshrc"
    link_dotfile "$DOTFILES_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

    # add more symlinks here, e.g.:
    # link_dotfile "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
}

git_config() {
    info "Setting git global configs..."
    git config --global credential.useHttpPath true
    git config --global user.name "Norbert Palinkas"
    git config --global user.useConfigOnly true
    git config --global push.autoSetupRemote true
    echo "AGENTS.md" >> ~/.gitignore_global
    git config --global core.excludesfile ~/.gitignore_global
}

# ---------- set default shell ----------
set_default_shell() {
    if [[ "$SHELL" == *"zsh"* ]]; then
        ok "Default shell is already zsh"
        return
    fi
    info "Setting zsh as default shell..."
    chsh -s "$(which zsh)"
    ok "Default shell set to zsh (restart your terminal)"
}

# ---------- main ----------
main() {
    echo ""
    echo "========================================="
    echo "  Dotfiles installer"
    echo "========================================="
    is_wsl && info "WSL2 environment detected" || info "Native Linux detected"
    echo ""

    install_packages
    install_oh_my_zsh
    install_p10k
    install_zsh_plugins
    warn_nerd_font
    create_symlinks
    git_config
    set_default_shell

    echo ""
    ok "All done! Restart your terminal or run: exec zsh"
    echo ""
}

main "$@"

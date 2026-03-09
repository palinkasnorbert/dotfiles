# dotfiles

Syncs zsh + oh-my-zsh + powerlevel10k + nerd font across machines (WSL2 & native Ubuntu).

## Quick start

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh update.sh
./install.sh
```

## Structure

```
dotfiles/
├── install.sh                  # Full setup (idempotent, safe to re-run)
├── update.sh                   # Pull latest + update oh-my-zsh & plugins
├── zsh/
│   ├── .zshrc                  # Main shell config
│   └── .p10k.zsh              # Powerlevel10k theme config
├── fonts/                      # Put your .ttf nerd font files here
├── scripts/
│   └── install-font-windows.ps1  # WSL2: install font on Windows side
└── .gitignore
```

## Adding your config

1. Run `p10k configure` on one machine, then copy the result in:
   ```bash
   cp ~/.p10k.zsh ~/dotfiles/zsh/.p10k.zsh
   ```
2. Download your nerd font `.ttf` files into `fonts/`.
3. Commit & push. On the other machine, `git pull && ./install.sh`.

## WSL2 font note

Fonts must be installed on the **Windows side** for your terminal to see them.
Either manually copy `.ttf` files to Windows Fonts, or from WSL run:

```bash
powershell.exe -File ~/dotfiles/scripts/install-font-windows.ps1
```

## Keeping in sync

From either machine:

```bash
dotup          # alias defined in .zshrc → runs update.sh
```

Or manually: `cd ~/dotfiles && git pull && ./install.sh`
# dotfiles

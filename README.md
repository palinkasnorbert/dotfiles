# dotfiles

Syncs zsh + oh-my-zsh + powerlevel10k across machines.

## Quick start

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

## Structure

```
dotfiles/
├── install.sh                  # Full setup (idempotent, safe to re-run)
├── README.md
├── fonts/                      # Nerd font files for manual installation
├── prompts/
│   └── initialize_agents.prompt.md
├── zsh/
│   ├── .zshrc                  # Main shell config
│   └── .p10k.zsh              # Powerlevel10k theme config
```

## Adding your config

1. Run `p10k configure` on one machine, then copy the result in:
   ```bash
   cp ~/.p10k.zsh ~/dotfiles/zsh/.p10k.zsh
   ```
2. Put your Nerd Font `.ttf` files into `fonts/`.
3. Commit & push. On the other machine, `git pull && ./install.sh`.

## Nerd font note

Install a Nerd Font manually from `fonts/` so Powerlevel10k renders correctly.
If you use WSL, install it in the terminal host on the Windows side.

## Keeping in sync

Run `git pull && ./install.sh` after changes.
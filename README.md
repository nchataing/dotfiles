# My dotfiles

## List of software / utilities that I use

- **dwm**
    + _bépo_: adjustments for keyboard
    + systray patch
    + install from submodule
- **st**: install from submodule
- **neovim** with the following general config
    + _lazy.nvim_ to pull packages
    + _bépo_: in order to keep minimal adjustments I remap `Alt+{c,t,r,s}` to the `hjkl` homerow.
    + light theme user - previously papercolor but it did not integrate really well with treesitter syntax highlight, currently `nvim-grey`
    + No lsp config yet, I use ctags
- **fzf**: for various utilities
- **tmux**
    + my main usage consists in having multiple sessions for each different contexts I work on; and switching between them with a fzf based script (see `tmux-switch-session`)
    + should be higher than version 3.3 for fzf integration (floating menus)
- **zsh**: shared shell setup lives in `zshrc`; machine-local secrets and one-off overrides should live in `~/.zshrc.local` (see `zshrc.local.example`).
- **pi**: global settings, prompt templates, skills and notification extension under `pi/agent/`.
- **desktop utilities**: dunst, ghostty, i3, X session startup, taskwarrior, gh-dash, k9s, Vim compatibility snippets and tmux session seeds are gathered in their matching directories/files.

## Local secrets policy

Do not commit real tokens, cookies, passwords, private keys, kube configs or SSH/GPG material. Keep them in local-only files such as `~/.zshrc.local` or tool-specific secret stores.


# Laptop configuration

## Lenovo Laptop - Charge Thresholds Setup (Ubuntu)

1. Install TLP:
   `sudo apt install tlp tlp-rdw`

2. Edit TLP config:
   `sudo -e /etc/tlp.conf`
   Set `START_CHARGE_THRESH_BAT0=75` and `STOP_CHARGE_THRESH_BAT0=80`

3. Apply and restart:
   `sudo tlp start`

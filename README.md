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

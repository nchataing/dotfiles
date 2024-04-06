# Misc
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
unsetopt beep
bindkey -e

# Completion
zstyle :compinstall filename '/home/nchataing/.zshrc'
autoload -Uz compinit
compinit

# Aliases
alias ls="ls --color=always"
alias startup="/home/nchataing/.tmux/tmux-session-startup.sh"
alias vim=nvim

# Env
export EDITOR=nvim
export FZF_DEFAULT_COMMAND='fd --type f -H'


# Prompt
PROMPT='%B%F{4}%~%f%b %# '

# Title screen
function update_term_cwd() {
  printf '\e]2;%s  %s\a' `echo $TERM | sed "s/-256color//"` `echo $PWD | sed -r "s#${HOME}#~#"`
}

autoload add-zsh-hook
add-zsh-hook chpwd update_term_cwd
update_term_cwd

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

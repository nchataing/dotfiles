# Misc
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
unsetopt beep
bindkey -e

# Completion
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

# Aliases
alias ls="ls --color=always"
alias startup="$HOME/.tmux/tmux-session-startup.sh"
alias k="kubectl"
alias tele="telepresence"
alias telepresenc="telepresence"
alias revault-env="source $HOME/scripts/revault-env.sh"
alias vim=nvim

# Env
export EDITOR=nvim
export VISUAL=nvim
export FZF_DEFAULT_COMMAND='fd --type f -H'

# Local binaries and toolchains
path=(
  "$HOME/.bun/bin"
  "$HOME/.local/nvim/bin"
  "${KREW_ROOT:-$HOME/.krew}/bin"
  "$HOME/.local/share/coursier/bin"
  "$HOME/.cargo/bin"
  "$HOME/.local/share/pnpm"
  "$HOME/.local/bin"
  "/usr/local/go/bin"
  "$HOME/.yarn/bin"
  "$HOME/.zig"
  $path
)
export PATH

# Ledger / Revault local defaults (secrets live in ~/.zshrc.local)
export VAULT_PROTOBUF_PATH="$HOME/w/hsm/build/install/protobuf"
export BOLOS_SDK="$HOME/w/AppDave_review/sdk/sdk-blue-2.2.11-eeld"
export VAULT_HSM_CLIENT_CERT_PATH="$HOME/work-doc/certs/client.pfx"
export LEDGER_PROXY_ADDRESS=127.0.0.1
export LEDGER_PROXY_PORT=9999
export VAULT_WORKSPACE_DIR="$HOME/w/"
export VAULT_COMPARTMENT_ID=1092

# Prompt
PROMPT='%B%F{4}%~%f%b %# '

# Title screen
function update_term_cwd() {
  printf '\e]2;%s  %s\a' "$(echo "$TERM" | sed "s/-256color//")" "$(echo "$PWD" | sed -r "s#${HOME}#~#")"
}

autoload add-zsh-hook
add-zsh-hook chpwd update_term_cwd
update_term_cwd

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# apt history helpers: install | remove | upgrade | rollback
function apt-history() {
  case "$1" in
    install)
      grep 'install ' /var/log/dpkg.log
      ;;
    upgrade|remove)
      grep "$1" /var/log/dpkg.log
      ;;
    rollback)
      grep upgrade /var/log/dpkg.log | \
        grep "$2" -A10000000 | \
        grep "$3" -B10000000 | \
        awk '{print $4"="$5}'
      ;;
    *)
      cat /var/log/dpkg.log
      ;;
  esac
}

# Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# OCaml
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null

# Bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"

# Machine-local secrets and one-off overrides.
# Keep tokens, cookies, passwords and API keys out of git.
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

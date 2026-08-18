export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  # zsh-syntax-highlighting
  fast-syntax-highlighting
  zsh-autosuggestions
  zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

bindkey '\e[A' up-line-or-history
bindkey '\eOA' up-line-or-history
bindkey '\e[B' down-line-or-history
bindkey '\eOB' down-line-or-history

sp() {
  local dir
  dir=$(rg $HOME/source/ --hidden --files --no-ignore-vcs --null --glob '!{.git,node_modules,build,dist,target}' | xargs -0 -I {} dirname {} | awk '!x[$0]++' | fzf) && cd "$dir" && tmux new-session -A -s `basename $PWD`
}
autoload -Uz sp

sc() {
  local dir
  dir=$(rg $HOME/.config/ --hidden --files --follow --no-ignore-vcs --null | xargs -0 -I {} dirname {} | awk '!x[$0]++' | fzf) && cd "$dir"
}
autoload -Uz sc

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

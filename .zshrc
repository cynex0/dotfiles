export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git 
  zsh-syntax-highlighting 
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
  dir=$(rg $HOME/.config/ --hidden --files --no-ignore-vcs --null --glob '!{.git,node_modules,build,dist,target}' | xargs -0 -I {} dirname {} | awk '!x[$0]++' | fzf) && cd "$dir"
}
autoload -Uz sc

alias 'setcharge'='sudo tlp setcharge 0 1'
alias 'fullcharge'='sudo tlp fullcharge'
alias 'waybar-top'='waybar -c ~/.config/waybar/top.jsonc'
alias 'waybar-bot'='waybar -c ~/.config/waybar/bot.jsonc'
alias 'vim'='nvim'
alias protontricks='flatpak run com.github.Matoking.protontricks'
alias protontricks-launch='flatpak run --command=protontricks-launch com.github.Matoking.protontricks'
alias air='~/go/bin/air'
alias untar='tar xvf'
alias untar-gz='tar zxvf'
alias dotfiles='git --git-dir=$HOME/source/dotfiles --work-tree=$HOME'



export JAVA_HOME=/usr/lib/jvm/java-21-openjdk/
export PATH=$JAVA_HOME/bin:$PATH

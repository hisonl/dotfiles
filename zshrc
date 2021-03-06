# ========================================
# path setting
# ========================================

##  重複パスを登録しない
typeset -U path cdpath fpath manpath

## sudo用のpathを設定
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local,/usr,}/sbin(N-/))

## pathを設定
path=(~/bin(N-/) /usr/local/bin(N-/) ${path})

## lsの色変更
export LSCOLORS=gxfxcxdxbxegedabagacad

## anaconda setting
export PATH=~/anaconda/bin:$PATH

## golang setting
export GOPATH=$HOME
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

## rbenv setting
eval "$(rbenv init -)"
source `brew --prefix rbenv`/completions/rbenv.zsh

## bundle open setting
export BUNDLER_EDITOR=vim

# ========================================
# direnv setting
# ========================================
eval "$(direnv hook $0)"

# ========================================
# peco setting
# ========================================
# コマンド履歴の検索・絞り込み
setopt hist_ignore_all_dups

function peco_select_history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco_select_history
bindkey '^r' peco_select_history

# ghqでクローンしてきたリポジトリへ移動
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# ========================================
# command alias
# ========================================
alias v='vim'
alias grep='grep --color'
alias g='git'
alias gg='git grep -H --heading --break'
alias ls='ls -FG'
alias l='ls -FGThgo'
alias la='ls -FGThgoa'
alias p='cd $(ghq list -p | peco); pwd'
alias binstub='bundle install --binstubs=,/bin'
alias exenv="echo 'export PATH=,/bin:./bin:$PATH' >> .envrc; direnv allow ."
alias unicorn='unicorn_rails -c config/unicorn.rb -E '
function grepr() {
  grep --color -r $1 .
}
function search() {
  find $1 -type f ! -path '*/.git/*' -print0 | xargs -0 grep -C1 '$2'
}
function rnew() {
  rails new $1 -m https://raw.githubusercontent.com/hisonl/rails_template/master/template.rb
}

#補完機能を使用する
autoload -U compinit promptinit
compinit
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*:default' menu select=1

#大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#補完でカラーを使用する
autoload colors
zstyle ':completion:*' list-colors "${LS_COLORS}"
colors

# beepを鳴らさないようにする
setopt nolistbeep

#kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

#カレントディレクトリを表示
PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})[%n] %{${reset_color}%}%"

autoload -Uz zmv

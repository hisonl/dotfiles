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

# ========================================
# rbenv setting
# ========================================
eval "$(rbenv init -)"
source `brew --prefix rbenv`/completions/rbenv.zsh

# command alias
alias grep='grep --color'
alias g='git'
alias l='ls -FGThgo'
alias la='ls -FGThgoa'
alias binit='bundle init; bundle install --path vendor/bundle'
alias rinit='bundle exec rails new . --skip-bundle'
alias be='bundle exec '
alias unicorn='bundle exec unicorn_rails -c config/unicorn.rb -E '
alias migrate:reset='bundle exec rake db:migrate:reset'

# project alias
alias rted='cd ~/Dev/rted/; ls'
alias neso='cd ~/Dev/neso-server/; ls'
alias aero='cd ~/Dev/aerosmith/; ls'
alias kazune='cd ~/Dev/Kazunematiks/; ls'

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

PATH=$HOME/.rbenv/shims:$PATH
eval "$(rbenv init - --no-rehash)"
export PATH=/usr/local/bin:$PATH

# command alias
alias g='git'
alias be='bundle exec '
alias unicorn='bundle exec unicorn_rails -c config/unicorn.rb -E '
alias ber='bundle exec rspec -c '

# project alias
alias go='cd ~/Dev/rted/; ls'
alias neso='cd ~/Dev/neso-server/; ls'

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

#kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

#カレントディレクトリを表示
PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})[%n] %{${reset_color}%}%"

autoload -Uz zmv

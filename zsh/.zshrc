HISTFILE=~/.cache/zsh/history
HISTSIZE=10000
SAVEHIST=10000

setopt AUTO_CD          # auto cd into path
setopt SHARE_HISTORY    # share history file across the sessions
setopt APPEND_HISTORY   # and append to it rather overwrite

bindkey -v
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

autoload -U promptinit; promptinit

# auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -D ~/.cache/zsh/zcompdump-$ZSH_VERSION

[ -f $HOME/dotfiles/aliases ] && source $HOME/dotfiles/aliases
LS_COLORS='di=94:ex=92:ln=36'
export LS_COLORS


ZSH_PATH=$HOME/dotfiles/zsh



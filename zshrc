setopt AUTO_CD                          # auto cd into path
setopt SHARE_HISTORY                    # share history file across the sessions
setopt APPEND_HISTORY                   # and append to it rather overwrite
setopt HIST_EXPIRE_DUPS_FIRST           # expire duplicate first
setopt HIST_IGNORE_DUPS                 # do not store duplications
setopt HIST_FIND_NO_DUPS                # ignore duplicate when searching
setopt HIST_REDUCE_BLANKS               # remove blank lines from histody
setopt INTERACTIVE_COMMENTS

export HISTFILE=$HOME/.zsh_history
export SAVEHIST=10000
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/zig
export FZF_DEFAULT_OPTS='--height 100% --layout=reverse --bind ctrl-p:toggle-preview'

function _is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

function preexec() {
  cmd_start=$(($(print -P %D{%s%6.}) / 1000))
  inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
}

function precmd() {
  print -Pn "\e]0;%1d\a"
  if [ $cmd_start ]; then
    local now=$(($(print -P %D{%s%6.}) / 1000))
    local d_ms=$(($now - $cmd_start))
    local d_s=$((d_ms / 1000))
    local ms=$((d_ms % 1000))
    local s=$((d_s % 60))
    local m=$(((d_s / 60) % 60))
    local h=$((d_s / 3600))

    if   ((h > 0)); then cmd_time=${h}h${m}m
    elif ((m > 0)); then cmd_time=${m}m${s}s
    elif ((s > 9)); then cmd_time=${s}.$(printf %03d $ms | cut -c1-2)s # 12.34s
    elif ((s > 0)); then cmd_time=${s}.$(printf %03d $ms)s # 1.234s
    else cmd_time=${ms}ms
    fi

    unset cmd_start
  else
    # Clear previous result when hitting Return with no command to execute
    unset cmd_time
  fi

  _is_in_git_repo && vcs_info
}
# prompt
autoload -Uz vcs_info # make sure vcs_info function is available
setopt prompt_subst # allow dynamic command prompt
zstyle ':vcs_info:*' check-for-changes true # unsubmitted changes
zstyle ':vcs_info:*' stagedstr '%{%F{green}%B%} ●%{%b%f%}' # staged changes
zstyle ':vcs_info:*' unstagedstr '%{%F{red}%B%} ●%{%b%f%}' # unstaged changes
zstyle ':vcs_info:*' formats '%{%F{green}%}%25>…>%b%<<%{%f%}%{%f%}%c%u'
RPROMPT='%F{cyan}$(if [ $cmd_time ]; then echo "($cmd_time) "; fi)%F{none}${vcs_info_msg_0_}'

PROMPT="%(?..%F{red}%? )"                       # error code
PROMPT="$PROMPT%F{240}%~%F{255}"                # cwd
NEWLINE=$'\n'
PROMPT="$PROMPT${NEWLINE}"
PROMPT="$PROMPT%n %F{240}$ "                    # username $
PROMPT="$PROMPT%F{yellow}%(1j.(%j) .)%f"        # jobs in background

alias cat='bat'
alias vim='nvim'
alias ls='ls --color=auto'
alias ll='ls -l'
alias all='ls -al'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
chpwd() { ll }                          # always list upon pwd changed
mcd () { mkdir -p "$1" && cd "$1"; }    # make new dir and cd into it

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    vim)          fzf "$@" --preview "bat --color=always {}" ;;
    *)            fzf "$@" ;;
  esac
}

_git_branch() {
  _is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --color=always $(sed s/^..// <<< {} | cut -d" " -f1)' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

_git_log() {
  _is_in_git_repo || return
  git log --color=always |
  fzf --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
  grep -o "[a-f0-9]\{7,\}"
}

# git aliases
alias ga='git add --patch'
alias gs='git status'
alias gc='git checkout'
alias gp='git pull'
alias gP='git push'
alias gd='git diff'
alias gl='git log'
alias gg='git graph'
alias gb='_git_branch'
alias gL='_git_log'

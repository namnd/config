setopt INTERACTIVE_COMMENTS

export PATH="$PATH:$HOME/flutter/bin"

hostname=$(cat /etc/hostname 2>/dev/null)

bindkey "^F" forward-word
bindkey "^B" backward-word

function _is_in_git_repo() { git rev-parse HEAD > /dev/null 2>&1 }
function _overwrite_kitty_tab_title() { 
  if [ $hostname ]; then
    print -Pn "\e]0;%1d($hostname)\a"
  else
    print -Pn "\e]0;%1d\a"
  fi
}

function chpwd() { ls -l --color=auto } # always list upon pwd changed
function preexec() { cmd_start=$(($(print -P %D{%s%6.}) / 1000)) }
function precmd() {
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

  vcs_info
  _overwrite_kitty_tab_title
}

# right prompt
autoload -Uz vcs_info # make sure vcs_info function is available
setopt prompt_subst # allow dynamic command prompt
zstyle ':vcs_info:*' check-for-changes true # unsubmitted changes
zstyle ':vcs_info:*' stagedstr '%{%F{green}%B%} ●%{%b%f%}' # staged changes
zstyle ':vcs_info:*' unstagedstr '%{%F{red}%B%} ●%{%b%f%}' # unstaged changes
zstyle ':vcs_info:*' formats '%{%F{green}%}%25>…>%b%<<%{%f%}%{%f%}%c%u'
RPROMPT='%F{cyan}$(if [ $cmd_time ]; then echo "($cmd_time) "; fi)%F{none}${vcs_info_msg_0_}'

# left prompt
PROMPT="%(?..%F{red}%? )"                       # error code
PROMPT="$PROMPT%F{240}%~%F{255}"                # cwd
NEWLINE=$'\n'
PROMPT="$PROMPT${NEWLINE}"
PROMPT="$PROMPT%n%F{240}"                       # username
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  PROMPT="$PROMPT@${hostname}%F{green}"
fi
PROMPT="$PROMPT $ "
PROMPT="$PROMPT%F{yellow}%(1j.(%j) .)%f"        # jobs in background

function cur_aws_vlt() {
  if [ -n "${AWS_VAULT}" ]; then
    color=yellow
    case $AWS_VAULT in
      stage)
        color=cyan
        ;;
      prod)
        color=magenta
        ;;
    esac
    date=$(date --date $AWS_SESSION_EXPIRATION +%H:%M)
    echo "%{%F{$color}%}($AWS_VAULT) %F{grey}% $date%{$reset_color%} "
  fi
}
PROMPT="%{$fg[yellow]%}$(cur_aws_vlt)%{$reset_color%}$PROMPT"

# specific for mac
if [[ `uname` == "Darwin" ]]; then
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  function pc() {
    defaults write org.p0deje.Maccy ignoreEvents true ;
    sleep 1;
    pass -c "$@" ;
    sleep 1;
    defaults write org.p0deje.Maccy ignoreEvents false;
  }
fi

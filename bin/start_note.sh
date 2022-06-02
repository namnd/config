#!/bin/zsh

emacs_started=0
temp=$(tmux list-panes -a -F '#{pane_pid} #I #P' | tr '\n' ':')
lines=("${(@s/:/)temp}")
for line in $lines
do
  part=("${(@s/ /)line}")
  pid=${part[1]}
  cid=$(pgrep -P $pid)
  if [ "$cid" != "" ]; then
    pname=$(ps -p $cid -o comm=)
    if [ "$pname" = "emacsclient" ]; then
      emacs_started=1
      tmux select-window -t ${part[2]}
    fi
  fi
done
if [ $emacs_started -eq 0 ]; then
  cd ~/notes && e
fi

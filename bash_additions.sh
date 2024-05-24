#!/bin/bash

# add to current bash or .bashrc with `source bashrc_additions.sh`

# aliases
alias l='ls -lha --group-directories-first'
alias r='rsync -a'
alias gs='git status'
alias gb='git branch'
alias gl='git log --graph --all'
alias gd='git diff'
alias gdc='git diff --cached'
alias ga='git add'
alias gc='git commit -m'
alias gpl='git pull'
alias gps='git push'

# convenient folder change
c() {
  if [ $# -eq 0 ]; then
    cd ..
  else
    cd "$1"
  fi
}

# tree 
t() {
  if [[ "$1" =~ ^[0-9]+$ ]]; then
    if [[ "$2" != "" ]]; then
      tree -L "$1" "$2"
    else
      tree -L "$1"
    fi
  elif [[ "$1" != "" ]]; then
    tree "$1"
  else
    tree
  fi
}

# find 
f() {
  find -L . -iname "*$1*"  
}

# grep 
g() {
  grep -R --color -inr -F "$1" .  
}

# grep and find 
gf() {
  g "$1"
  f "$1"
}

# trash 
d() {
  trash-put "$@"
}

# open file with default gui application
o() {
  xdg-open "$@" &> /dev/null
}

# enable changing titles of terminal windows
# https://unix.stackexchange.com/questions/177572/how-to-rename-terminal-tab-title-in-gnome-terminal
#function set_terminal_title() {
#  if [[ -z "$ORIG" ]]; then
#    ORIG=$PS1
#  fi
#  TITLE="\[\e]2;$*\a\]"
#  PS1=${ORIG}${TITLE}
#}

# add custom scripts folder to path
if [[ ":$PATH:" != *":${HOME}/main/3__sys/scripts/:"* ]]; then
    export PATH="${HOME}/main/3__sys/scripts/:$PATH"
fi

# in bash to the left, show only user, not host, and only current folder
#export PS1="\[\e[32m\]\u:\[\e[34m\]\W\[\e[30m\]$ "
# for normal user:
export PS1="\[\e[01;32m\]\u:\[\033[01;34m\]\W\[\033[00m\]\$ "
# for root:
#export PS1="\[\e[01;31m\]\u:\[\033[01;34m\]\W\[\033[00m\]\$ "

# show current folder as terminal title
# for normal user:
PROMPT_COMMAND='echo -ne "\033]0;${PWD/${PWD%*/*}\/}\007"'
# for root:
#PROMPT_COMMAND='echo -ne "\033]0;root: ${PWD/${PWD%*/*}\/}\007"'

# disable XOFF, so that ctrl+s can be used for going back in bash reverse-i search (ctrl-r)
stty -ixon

# add hidden files to bash expansion
shopt -s dotglob


#!/bin/bash

# add content directly to ~.bashrc or load it with `source /path/to/bashrc_additions.sh`
#
# optional additional environment needed to be set manually in ~.bashrc variables for some 
# functions:
# - custom_var_bookmarks: for custom function `c`, uncomment below or copy
# custom_var_bookmarks=/path/to/bookmarks/
# - custom_var_scripts: for loading additional custom scripts into $PATH, uncomment below or copy
# custom_var_scripts=/path/to/scripts/


# aliases

# general aliases
alias l='ls -lha --group-directories-first && pwd'
alias r='rsync -a'
alias dc='docker-compose'
alias m='flatpak run org.gnome.Meld'

# git aliases
alias gs='git status'
alias gb='git branch'
alias gr='git remote -v'
alias gl='git log --graph --all'
alias gd='git diff'
alias gdc='git diff --cached'
alias ga='git add'
alias gc='git commit -m'
alias gpl='git pull'
alias gps='git push'


# function `c`
# convenient folder change with integrated bookmarks autocomplete

# add folder with custom sym links (treated as bookmarks) to CDPATH, so that `cd` can use it
# anywhere 
if [[ ":${CDPATH}:" != *":${custom_var_bookmarks}:"* ]]; then
    export CDPATH="${custom_var_bookmarks}:$CDPATH"
fi
# reuse autocomplete functionality of `cd`
complete -o nospace -F _cd c
c() {
  # if no param is passed, go one folder above
  if [ $# -eq 0 ]; then
    cd .. && l
  # if param is passed, go there
  else
    cd -P "$1" > /dev/null && l
  fi
}


# function `t`
# quick tree call, with optional first parameter being depth and seccond a specific folder
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


# function `f`
# quick find 
f() {
  find -L . -iname "*$1*"  
}


# function `g`
# quick grep 
g() {
  grep -R --color -inr -F "$1" .  
}


# function `gf`
# quick grep and find 
gf() {
  g "$1"
  f "$1"
}


# function `d`
# quick trash 
d() {
  trash-put "$@"
}


# function `o`
# open file with default gui application
o() {
  xdg-open "$@" &> /dev/null
}


# function `s`
# quick cat
s() {
  cat "$@"
}


# add custom scripts folder to $PATH
if [[ ":$PATH:" != *":${custom_var_scripts}:"* ]]; then
    export PATH="${custom_var_scripts}:$PATH"
fi


# commandline status and coloring
# show only user, no host, and only current folder
# for normal user (cyan):
export PS1="\[\e[30;01;106m\]\[\033[30;01;106m\]:\[\033[00m\] "
# for root (red):
#export PS1="\[\e[30;01;101m\]\[\033[30;01;101m\]:\[\033[00m\] "


# show current folder as terminal title (and show `root` explicitley)
# for normal user:
PROMPT_COMMAND='echo -ne "\033]0;${PWD/${PWD%*/*}\/}\007"'
# for root:
#PROMPT_COMMAND='echo -ne "\033]0;root: ${PWD/${PWD%*/*}\/}\007"'


# various input controls

# disable XOFF, so that ctrl+s can be used for going back in bash reverse-i search (ctrl-r)
stty -ixon

# add hidden files to bash expansion
shopt -s dotglob

# change interrupt to ctrl-x
stty intr ^X

# remap delete word from ctrl-w to ctrl-backpsace
stty werase \^H


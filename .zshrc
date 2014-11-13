# Global Config
ZSH=$HOME/.oh-my-zsh
# ZSH_THEME="muse"
# ZSH_THEME="xiong-chiamiov-plus"
ZSH_THEME="pure"
# ZSH_THEME="adben"
# ZSH_THEME="frisk"
# ZSH_THEME="random"
# ZSH_THEME="candy"

CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

# ZSH Plugins
plugins=(git git-flow git-extras sublime coffee python autojump brew cake encode64 fabric node npm osx pip urltools virtualenvwrapper)

source $ZSH/oh-my-zsh.sh

#---------------------------------------------------------------------
# env
export HOME=/Users/sschmid
export EDITOR=vim
export GVIM="/Users/sschmid/bin/gvim"
export EMAIL="Sven Schmid <sven.schmid@nexiles.com>"

#---------------------------------------------------------------------
# virtualenv
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
export PROJECT_HOME=$HOME/develop
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENV_ROOT=$WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh

#---------------------------------------------------------------------
# python
export JYTHON_HOME=/usr/local/Cellar/jython/2.5.3b1/libexec

#---------------------------------------------------------------------
# node.js
export NODE_PATH=/usr/local/lib/node
export JS_CMD=node

#---------------------------------------------------------------------
# ruby rvm
source ~/.rvm/scripts/rvm

#---------------------------------------------------------------------
# path
export PATH=~/bin:~/.rvm/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:$PATH

#---------------------------------------------------------------------
# aliases
alias rmds='find . -name .DS_Store -type f -exec rm {} \;'
alias ls="gls --color"
alias la="ls -la"
alias ll="gls -lah --color"
alias l="ls -lah"
alias grep='grep --color'
alias df='df -h'
alias zfg="./bin/instance fg;stty sane"
alias zfb="./bin/buildout -v"
alias daily="mvim ~/Dropbox/daily/$(date '+%Y-%m-%d').rst"
alias todo="mvim ~/Dropbox/todos.taskpaper"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias blender="/opt/homebrew-cask/Caskroom/blender/2.72b/Blender/blender.app/Contents/MacOS/blender"

#---------------------------------------------------------------------
# wt stuff
export WT_HOME=/Volumes/settr-vm-ptc/Windchill
export WTUSER=orgadmin
export WTPASS=orgadmin

alias cdwt='cd $WT_HOME'

#---------------------------------------------------------------------
# zsh stuff
unsetopt correct_all


#---------------------------------------------------------------------
# sublime
export EDITOR='subl -w'


# vim: set ft=zsh ts=4 sw=4 expandtab :

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

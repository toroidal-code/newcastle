#!/bin/bash

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# variables
export EDITOR="emacs"

# bash aliases
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

PATH=$PATH:/usr/local/rvm/bin # Add RVM to PATH for scripting

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export NVM_DIR="/home/kate/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# added by travis gem
[ -f /home/kate/.travis/travis.sh ] && source /home/kate/.travis/travis.sh

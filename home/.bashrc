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

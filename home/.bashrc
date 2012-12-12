#!/bin/bash

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

function _update_ps1()
{
   export PS1="$(~/.powerline-bash/powerline-bash.py $?)"
 }

 export PROMPT_COMMAND="_update_ps1"

# variables
export EDITOR="emacs"

# bash aliases
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

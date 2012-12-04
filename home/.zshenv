#!/bin/zsh

# Load OS scripts/software
source /etc/profile

# Bins and scripts
if [[ $EUID -ne 0 ]]; then
	export PATH=$PATH:~/Bin:~/Repos/castle/scripts
fi

# Other variables
export EDITOR=emacs

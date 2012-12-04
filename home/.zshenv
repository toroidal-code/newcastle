#!/bin/zsh

if command -v brew &>/dev/null; then
        # homebrew
        export PATH=/usr/local/bin:/usr/local/sbin:$PATH
fi


# Load OS scripts/software
source /etc/profile

# Bins and scripts
if [[ $EUID -ne 0 ]]; then
	export PATH=$PATH:~/Bin:~/Repos/castle/scripts
fi

# Other variables
export EDITOR=emacs

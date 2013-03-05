NEWCASTLE="zsh"

export PATH=~/.bin:$PATH
#export BYOBU_PREFIX=$(brew --prefix)
export PATH=/usr/local/Cellar/ruby/1.9.3-p362/bin:~/.bin:$PATH

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

autoload -U compinit; compinit

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

if [ $NEWCASTLE = "omz" ]; then
	# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
	# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
	# Example format: plugins=(rails git textmate ruby lighthouse)
	plugins=(git)

	source $ZSH/oh-my-zsh.sh	

elif [ $NEWCASTLE = "prezto" ]; then
	# Source Prezto.
	if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
	  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
	fi
fi

# Completions
autoload -U compinit; compinit

# Arrow key menu for completions
zstyle ':completion:*' menu select

# Case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Set up aliases
. ~/.aliases
. ~/.lulz

# Autocomplete command line switches for aliases
setopt completealiases

# Set up history
# number of lines kept in history
export HISTSIZE=1000
# number of lines saved in the history after logout
export SAVEHIST=1000
# location of history
export HISTFILE=~/.zsh_history
# append command to history file once executed
setopt inc_append_history
# only show past commands that include the current input
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

if [ $NEWCASTLE = "zsh" ]
	then
		function _update_ps1()
		{
			export PROMPT="$(~/.powerline-zsh/powerline-zsh.py --cwd-only $?)"	
			PROMPT="$PROMPT"`$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")`
		}

		precmd()
		{
			_update_ps1
		}
elif [ $NEWCASTLE = "simple-zsh" ]; then
    # Function that displays the hostname if the current session is over SSH
    function ssh_info() {
    if [[ -n $SSH_CONNECTION ]]; then
	echo "%{$fg[blue]%}$(hostname) "
    fi
    }
    
    # Prompt
    autoload -U colors && colors
    setopt prompt_subst
    export PROMPT='$(ssh_info)%{$fg[cyan]%}%~ $(vc_info)%{$fg[cyan]%}%# %{$reset_color%}'

fi
# Colored man pages (from https://wiki.archlinux.org/index.php/Man_Page#Colored_man_pages)
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh ]]
    export PATH=/usr/local/share/npm/bin:/usr/local/share/python3:$PATH
    export BYOBU_PREFIX=$(brew --prefix)
fi

#source $HOME/.rvm/scripts/rvm

# Load zmv
autoload -U zmv

# Load autocorrect things
#setopt correctall

export PATH=/usr/local/share/npm/bin:$PATH

export NODE_PATH=/Users/kate/.nvm/v0.8.16/lib/node_modules

. ~/.nvm/nvm.sh

PATH=$PATH:/usr/local/rvm/bin # Add RVM to PATH for scripting

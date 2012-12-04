# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Completions
autoload -U compinit
compinit -C

# Arrow key menu for completions
zstyle ':completion:*' menu select

# Case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Set up aliases
. ~/.aliases

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

# Function that displays the hostname if the current session is over SSH
function ssh_info() {
	if [[ -n $SSH_CONNECTION ]]; then
		echo "%{$fg[blue]%}$(hostname) "
	fi
}

# Displays version control information if in a repository
if command -v vcprompt > /dev/null; then
	has_vcprompt=true
else
	has_vcprompt=false
fi
function() vc_info() {
	if $has_vcprompt; then
		vc_branch=$(vcprompt -f "%b")
		if [[ -n $vc_branch ]]; then
			vc_status=$(vcprompt -f "%m%u")
			echo "%{$fg[cyan]%}$vc_branch%{$fg[green]%}$vc_status%{$reset_color%} "
		fi
	fi
}

# Prompt
autoload -U colors && colors
setopt prompt_subst
export PROMPT='$(ssh_info)%{$fg[cyan]%}%~ $(vc_info)%{$fg[cyan]%}%# %{$reset_color%}'

# Set up the title bar text
title_info() {
	print -Pn "\e]2;%~\a"
}

# Enable title bar info display
# This gets called every time the working directory changes.
chpwd() {
	[[ -t 1 ]] || return
	title_info
}
# This extra call is here so that the title bar will also be set when a new
# terminal is created.
title_info

# Load zmv
autoload -U zmv

# Load autocorrect things
#setopt correctall

# Automatically use cd when paths are entered without cd
#setopt autocd

export NEWCASTLE="prezto"

if [ $COLORTERM  ] && [ $COLORTERM = "gnome-terminal" ]; then
	export TERM=xterm-256color
fi

if [[ -n $SSH_CONNECTION ]]; then
	NEWCASTLE="simple-zsh"
else
	NEWCASTLE="prezto"
fi

if [ $NEWCASTLE = "prezto" ]; then
	# Source Prezto.
	if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
	  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
	fi

elif [ $NEWCASTLE = "powerline" ]; then
    #. ~/.powerline/powerline/bindings/zsh/powerline.zsh
	function _update_ps1()
	{
		export PROMPT="$(~/git/powerline-shell/powerline-shell.py --cwd-only --shell zsh $?)"
		export RPROMPT="$(~/git/powerline-shell/powerline-shell-right.py --shell zsh)"	
		#export PROMPT="$(~/git/powerline-zsh/powerline-zsh.py --cwd-only $?)"
		PROMPT="$PROMPT"`$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")`
	}

	precmd()
	{
		_update_ps1
	}
elif [ $NEWCASTLE = "zsh" ]; then
    # Function that displays the hostname if the current session is over SSH
    function ssh_info() {
        if [[ -n $SSH_CONNECTION ]]; then
	        echo "%{$fg[blue]%}$(hostname) "
        fi
    }
    precmd(){ vcs_info }    
    # Prompt
    autoload -U colors && colors
    setopt prompt_subst
    export PROMPT='$(ssh_info)%{$fg[cyan]%}%~ ${vcs_info_msg_0_}%{$fg[cyan]%}%# %{$reset_color%}'

fi

# Completions
autoload -U compinit; compinit

# Arrow key menu for completions
zstyle ':completion:*' menu select

# Case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#vcs info
autoload -U vcs_info # load the plugin
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn

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
    export PATH=/usr/local/share/npm/bin:$PATH
    export BYOBU_PREFIX=$(brew --prefix)
    export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:/Users/Katherine/perl5";
    export PERL_MB_OPT="--install_base /Users/Katherine/perl5";
    export PERL_MM_OPT="INSTALL_BASE=/Users/Katherine/perl5";
    export PERL5LIB="/Users/Katherine/perl5/lib/perl5:$PERL5LIB";
    export PATH="/Users/Katherine/perl5/bin:$PATH";
    export PATH=/usr/local/Cellar/ruby/1.9.3-p362/bin:~/.bin:$PATH
fi

# Load zmv
autoload -U zmv

# Load autocorrect things
#setopt correctall

#begin .cvsrc
export CVSROOT=www5610@glados.cs.rit.edu:/home/stu1/s6/www5610/cvs
export CVS_RSH=ssh
alias   cvsstat='cvs status \!* |& grep Status:'
alias   cvswhat='cvs status \!* |& grep Status: |& grep -v "to-date"'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=~/.bin:$PATH
export CAML_LD_LIBRARY_PATH=/usr/lib/ocaml:${CAML_LD_LIBRARY_PATH}

PATH="/home/kate/perl5/bin${PATH+:}$PATH"; export PATH;
PERL5LIB="/home/kate/perl5/lib/perl5${PERL5LIB+:}$PERL5LIB"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/kate/perl5${PERL_LOCAL_LIB_ROOT+:}$PERL_LOCAL_LIB_ROOT"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/kate/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/kate/perl5"; export PERL_MM_OPT;

# OPAM configuration
. /home/kate/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

PATH=/home/kate/.gem/ruby/2.1.0/bin:$PATH

#!/bin/zsh

# RUBY
#export PATH=/home/kate/.gem/ruby/2.3.0/bin:$PATH
#export GEM_HOME=/home/kate/.gem

# WINE
export WINEARCH=win32

# Load OS scripts/software
emulate sh
source /etc/profile
emulate zsh

export PATH=~/.bin:$PATH

###Other variables### 
export ME=toroidal-code
export HOMEBREW_GITHUB_API_TOKEN=1330632441a71d5c7ae4d85cc7a968dbd913c8c7 

# export LD_LIBRARY_PATH=/home/kate/.go/src/github.com/cloudson/gitql/libgit2/install/lib
export LADSPA_PATH=/usr/lib/ladspa:/usr/local/lib/ladspa:~/.ladspa

#
# Perl
#
export PERL5LIB="/home/kate/perl5/lib/perl5${PERL5LIB+:}$PERL5LIB"
export PERL_LOCAL_LIB_ROOT="/home/kate/perl5${PERL_LOCAL_LIB_ROOT+:}$PERL_LOCAL_LIB_ROOT"
export PERL_MB_OPT="--install_base \"/home/kate/perl5\""
export PERL_MM_OPT="INSTALL_BASE=/home/kate/perl5"

#
# OCaml
#
#export OCAMLPATH=/usr/lib/ocaml:$OCAMLPATH
export CAML_LD_LIBRARY_PATH=/usr/lib/ocaml:${CAML_LD_LIBRARY_PATH}

#
# Go
#
export GOPATH=~/.go


#
# Browser
#
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#
export EDITOR='emacsclient -c'
export VISUAL='emacsclient -c'
export PAGER='less'
export ALTERNATE_EDITOR='/usr/local/bin/emacsnw'

#
# Compilers
#
export CC=clang
export CXX=clang++

#
# Language
#

if [[ -z "$LANG" ]]; then
  eval "$(locale)"
fi

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

#
# Paths
#

typeset -gU cdpath fpath mailpath manpath path
typeset -gUT INFOPATH infopath

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that info searches for manuals.
infopath=(
  /usr/local/share/info
  /usr/share/info
  $infopath
)

# Set the list of directories that man searches for manuals.
manpath=(
  /usr/local/share/man
  /usr/share/man
  $manpath
)

#for path_file in /etc/manpaths.d/*(.N); do
#  manpath+=($(<$path_file))
#done
#unset path_file

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  /usr/{bin,sbin}
  /{bin,sbin}
#  .bin
  $path
)

for path_file in /etc/paths.d/*(.N); do
  path+=($(<$path_file))
done
unset path_file

#
# Temporary Files
#

if [[ -d "$TMPDIR" ]]; then
  export TMPPREFIX="${TMPDIR%/}/zsh"
  if [[ ! -d "$TMPPREFIX" ]]; then
    mkdir -p "$TMPPREFIX"
  fi
fi

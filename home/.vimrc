""""""""""
" Vundle "
""""""""""

set nocompatible " disable vi compatibility
filetype off " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
source ~/.plugins.vim " load plugin list
call vundle#end()
filetype plugin indent on " required

"""""""""""
" AirLine "
"""""""""""

let g:airline_powerline_fonts = 1

""""""
" UI "
""""""

" automatically load changed files
set autoread

" auto-reload vimrc
autocmd! bufwritepost vimrc source ~/.vim/vimrc
"autocmd! bufwritepost gvimrc source ~/.vim/gvimrc

" show the filename in the window titlebar
set title

" set encoding
set encoding=utf-8

" directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backupf

" display incomplete commands at the bottom
set showcmd

" mouse support
set mouse=a

" line numbers
set number

" highlight cursor line
set cursorline

" wrapping stuff
"set textwidth=80
"set colorcolumn=80

" ignore whitespace in diff mode
set diffopt+=iwhite

" Powerline
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim
set laststatus=2
"let g:Powerline_symbols='unicode'
"let g:Powerline_symbols = 'fancy'
"let g:Powerline_colorscheme='default'

" Allow backspace to remove text not from current session
set backspace=indent,eol,start

" remember last cursor position
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\ 	exe "normal g`\"" |
	\ endif

" show '>   ' at the beginning of lines that are automatically wrapped
set showbreak=>\ \ \ 

" disable folds
set foldenable

" enable completion
set ofu=syntaxcomplete#Complete

" make laggy connections work faster
set ttyfast

"""""""""""""
" Searching "
"""""""""""""

set hlsearch "when there is a previous search pattern, highlight all its matches
set incsearch "while typing a search command, show immediately where the so far typed pattern matches
set ignorecase "ignore case in search patterns
set smartcase "override the 'ignorecase' option if the search pattern
set gdefault "imply global for new searches

"""""""""""""
" Indenting "
"""""""""""""

" Number of spaces that a <Tab> in the file counts for
set tabstop=4
" Number of spaces to use for each step of (auto)indent
set shiftwidth=4
" Use spaces, not tabs, for indents
set expandtab
" When auto-indenting, use the indenting format of the previous line
set copyindent
" When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
" 'tabstop' is used in other places. A <BS> will delete a 'shiftwidth' worth of
" space at the start of the line.
set smarttab
" Copy indent from current line when starting a new line (typing <CR> in Insert
" mode or when using the "o" or "O" command)
set autoindent
" Automatically inserts one extra level of indentation in some cases, and works
" for C-like files
set smartindent

"""""""""
" Theme "
"""""""""

syntax enable
set background=dark
colorscheme molokai
"colorscheme Tomorrow-Night-Bright
"colorscheme solarized 

""""""""
" GVim "
""""""""

"set gfn=Source\ Code\ Pro\ for\ Powerline\ 10 "set font
set gfn=Monospace\ 10
set gcr=n:blinkon0 "disable cursor blinking

set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar
set guioptions-=L "remove left scroll bar
set guioptions-=r "remove right scroll bar



""""""""""""
" Mappings "
""""""""""""

" change leader from \ to ,
let mapleader=","

" enter vim commands without having to press shift
map ; :

" typing ;; quickly exits insert mode
"ino ii 
map! ii <Esc>
"cno ` <c-c>

" delete individual lines with ctrl-k
map  <C-K>    dd
imap <C-K>    <C-O>dd

" toggle NERD Commenter
map <Leader>/ <Plug>NERDCommenterToggle

" toggle NERD Tree
map <Leader>n :NERDTreeToggle<CR>

" toggle Taglist
map <Leader>l :TlistToggle<CR>

" toggle spell check
map <Leader>s :set spell!<CR>

" more spell check shortcuts
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" toggle invisible character display
map <Leader>h :set list!<CR>

" run/compile file (see custom commands section)
map <Leader>r :make<CR>

" Format the current paragraph according to
" the current 'textwidth' with ctrl-j:
nmap <C-J>      gqap
vmap <C-J>      gq
imap <C-J>      <C-O>gqap

" tabs
map <Leader>tp :tabp<CR>
map <Leader>tn :tabnext<CR>

" opens an edit command with the path of the currently edited file filled in
" normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" opens a tab edit command with the path of the currently edited file filled in
" normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" inserts the path of the currently edited file into a command
" command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

nmap <F8> :TagbarToggle<CR>

"""""""""""""""""""""
" Language-Specific "
"""""""""""""""""""""

" configure <Leader>r shortcut (run/compile file depending on extension)
au BufNewFile,BufRead *.sh    setlocal makeprg=bash\ %
au BufNewFile,BufRead *.zsh   setlocal makeprg=zsh\ %
au BufNewFile,BufRead *.java  setlocal makeprg=javac\ %
au BufNewFile,BufRead *.rb    setlocal makeprg=ruby\ %
au BufNewFile,BufRead *.py    setlocal makeprg=python\ %
au BufNewFile,BufRead *.lisp  setlocal makeprg=clisp\ %
au BufNewFile,BufRead *.lua   setlocal makeprg=lua\ %
au BufNewFile,BufRead *.html  setlocal makeprg=chromium\ %

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby
au BufRead,BufNewFile *.html.erb set ft=eruby

"""""""""""""""""""
" Custom Commands "
"""""""""""""""""""

" remove trailing whitespace from all lines in the current buffer
command! Rtrim call <SID>RightTrim()
function! <SID>RightTrim()
	:% s/\s*$//g
	nohl
endfunction

" diff unsaved changes to file
if !exists(":Fdiff")
	command Fdiff vert new | set bt=nofile | r # | 0d_ | diffthis
		\ | wincmd p | diffthis
endif

" indents: convert spaces to tabs
command! -range=% -nargs=0 IndentTabs execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

" indents: convert tabs to spaces
command! -range=% -nargs=0 IndentSpaces execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'

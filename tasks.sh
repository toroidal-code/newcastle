#!/bin/bash

# Simple Rakefile-esque task runner.
# Call it like this:
#
#   ./tasks.sh pull symlink
#
# or just:
#
#   ./tasks.sh
#
# which will execute the pull, symlink, and update_vim_plugins tasks.

check_wget () {
	if ! command -v wget > /dev/null; then
		echo "Installation failed. Please install wget."
		popd > /dev/null
		exit 1
	fi
}

check_sbcl () {
	if ! command -v sbcl > /dev/null; then
		echo "Installation failed. Please install sbcl"
		popd > /dev/null
		exit 1
	fi
}

install_quicklisp () {
        echo "Installing quicklisp"
	mkdir ~/tmp
	cd ~/tmp
	curl -O http://beta.quicklisp.org/quicklisp.lisp
	sbcl --load quicklisp.lisp <<EOF
(quicklisp-quickstart:install)
(ql:quickload "quicklisp-slime-helper")
(ql:add-to-init-file)
EOF
	cd ..
	rm -rf ~/tmp
	echo "Done installing quicklisp"
}

install_elget () {
	echo "Installing el-get"
	curl -O https://raw.github.com/toroidal-code/newcastle/master/elget.el
	emacs -nw --load "./elget.el"
	rm ./elget.el
	echo "Done installing El-Get"
}

install_emacs_plugins () {
        echo "Installing emacs plugins"
	curl -O https://raw.github.com/toroidal-code/newcastle/master/plugins.el
	emacs -nw --batch --insert=plugins.el -f "eval-current-buffer"
	rm plugins.el
	echo "Done installing emacs plugins"
}

install_nvm () {
	git clone git://github.com/creationix/nvm.git ~/.nvm
	echo ". ~/.nvm/nvm.sh" >> ~/.zshrc
	source ~/.nvm/nvm.sh
	nvm install 0.8
	nvm alias default 0.8
}

install_rvm (){
        curl -L https://get.rvm.io | bash -s stable --ruby
}

uninstall () {
	echo "Uninstalling toroidal-code/newcastle..."
	rm -rf ~/.homesick
	rm ~/.homeshick
	echo "Done. You may need to manually delete leftover symlinks."
}

clone () {
	echo "Cloning repository..."
	$HOMESICK clone https://github.com/toroidal-code/newcastle.git
}

pull () {
	echo "Pulling repository..."
	$HOMESICK pull newcastle
}

symlink () {
	echo "Symlinking config files..."
	$HOMESICK symlink newcastle
}

set_up_repos_directory () {
	echo "Setting up ~/Repos..."
	if [ ! -d "$HOME/Repos" ]; then
		mkdir $HOME/Repos
	fi
	ln -s $HOME/.homesick/repos/newcastle $HOME/Repos/newcastle
}

clean () {
	pushd ~/.homesick/repos/newcastle > /dev/null
	echo "Cleaning repository..."
	git clean -dfx
	pushd > /dev/null
}

install_homeshick () {
	echo "Installing homeshick..."
        curl https://raw.github.com/andsens/homeshick/master/install.sh | bash
}

use_zsh () {
	echo "Switching shell to zsh..."
	sudo chsh --shell /bin/zsh `whoami`
}

install_vundle () {
	echo "Installing vundle..."
	if [ ! -d "$HOME/.vim/bundle" ]; then
		mkdir $HOME/.vim/bundle
	fi
	if [ ! -d "$HOME/.vim/bundle/vundle" ]; then
		git clone -q https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
	fi
}

install_vim_plugins () {
	echo "Installing vim plugins..."
	vim +BundleInstall +qall
}

update_vim_plugins () {
	echo "Updating vim plugins..."
	vim +BundleInstall! +qall
}

check_homesick() {
        if ! command -v homesick > /dev/null; then
	    export HOMESICK=homesick
	else
	    export HOMESICK=$HOME/.homeshick
	    install_homeshick
	fi
}

install () {
	echo "Installing toroidal-code/newcastle..."
	check_wget
	check_sbcl
	check_homesick
	clone
	use_zsh
	symlink
	set_up_repos_directory
	install_quicklisp
#	install_elget
#	install_emacs_plugins
	install_vundle
	install_vim_plugins
	install_nvm
	install_rvm
	echo "Open a new terminal to start your proper shell."
}

pushd $HOME > /dev/null
if [ $# -gt 0 ]
then
	for i in $@
	do
		[ "`type -t $i`" == "function" ] && $i || echo "No task named $i."
	done
else
	pull
	symlink
	update_vim_plugins
fi
popd > /dev/null

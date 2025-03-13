# deploy custom dotfiles to the current user's HOMEDIR

HOME?=	/root
VIMCOLORS!=	find vim/colors -type f

all: $(HOME)/.zshrc \
	$(HOME)/.vim/vimrc \
	$(HOME)/.vim/colors/xoria256.vim \
	$(HOME)/.pythonrc.py \
	$(HOME)/.gitconfig

$(HOME)/.zshrc:
	install zsh/.zshrc $@

$(HOME)/.vim:
	mkdir -p $@

$(HOME)/.vim/tmp: $(HOME)/.vim
	mkdir -p $@

$(HOME)/.vim/vimrc: $(HOME)/.vim
	install vim/.vim/vimrc $@

$(HOME)/.vim/colors: $(HOME)/.vim
	mkdir -p $@

$(HOME)/.vim/colors/xoria256.vim: $(HOME)/.vim/colors
	install vim/.vim/colors/xoria256.vim $@

$(HOME)/.pythonrc.py:
	install python/.pythonrc.py $@

$(HOME)/.gitconfig:
	install git/.gitconfig $@

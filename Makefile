# deploy custom dotfiles to the current user's HOMEDIR

HOME?=	/root
VIMCOLORS!=	find vim/colors -type f

all: $(HOME)/.zshrc \
	$(HOME)/.vimrc \
	$(HOME)/.pythonrc.py \
	$(HOME)/.gitconfig

$(HOME)/.zshrc! $(HOME)/.vim/tmp $(HOME)/.vim/colors/xoria256.vim
	install zsh/zshrc $@

$(HOME)/.vim/tmp:
	mkdir -p $@

$(HOME)/.vimrc!
	install vim/vimrc $@

$(HOME)/.vim/colors:
	mkdir -p $@

$(HOME)/.vim/colors/xoria256.vim! $(HOME)/.vim/colors
	install vim/colors/xoria256.vim $@

$(HOME)/.pythonrc.py!
	install python/pythonrc.py $@

$(HOME)/.gitconfig!
	install git/gitconfig $@

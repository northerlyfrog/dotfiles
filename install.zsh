#!/bin/zsh

# Change shell for current user to zsh
if [ ! "$SHELL" = "/bin/zsh" ]; then
	chsh -s /bin/zsh
fi

echo "Checking for homebrew..."
# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
	echo "Installing homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	echo "brew is installed"
	# Update homebrew recipes
	brew update

	brew rm vim macvim python
	brew install git
	brew install python
	brew install vim --with-override-system-vi --with-lua
	brew install macvim --with-override-system-vim
	brew install node go cmake

	npm install -g typescript

fi

# remove old dot files
rm ~/.gitconfig
#rm ~/.gitignore_global
#rm ~/.tmux.conf
rm ~/.vimrc
rm ~/.zshrc

# link new dot files
ln ~/.dotfiles/dots/home/gitconfig               ~/.gitconfig
#ln ~/.dotfiles/dots/home/gitignore_global        ~/.gitignore_global
#ln ~/.dotfiles/dots/home/tmux.conf               ~/.tmux.conf
ln ~/.dotfiles/dots/home/vimrc                   ~/.vimrc
ln ~/.dotfiles/dots/home/zshrc                   ~/.zshrc
ln ~/.dotsfiles/dots/home/tern-project           ~/.tern-project

cp ~/.dotfiles/dots/home/bullet-train.zsh-theme  ~/.oh-my-zsh/themes/bullet-train.zsh-theme

# install powerline fonts
~/.dotfiles/powerline-fonts/install.sh

# Set up YouCompleteMe
vim +PluginInstall +qall
cd ~/.vim/bundle/YouCompleteMe
./install.py --gocode-completer --tern-completer


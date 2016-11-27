#!/bin/zsh

# Change shell for current user to zsh
if [ ! "$SHELL" = "/bin/zsh" ]; then
  chsh -s /bin/zsh
fi

# remove old dot files
rm ~/.gitconfig
rm ~/.gitignore_global
rm ~/.tmux.conf
rm ~/.vimrc
rm ~/.zshrc

# link new dot files
ln ~/.dotfiles/dots/home/gitconfig               ~/.gitconfig
#ln ~/.dotfiles/dots/home/gitignore_global        ~/.gitignore_global
#ln ~/.dotfiles/dots/home/tmux.conf               ~/.tmux.conf
ln ~/.dotfiles/dots/home/vimrc                   ~/.vimrc
ln ~/.dotfiles/dots/home/zshrc                   ~/.zshrc

# install powerline fonts
~/.dotfiles/powerline-fonts/install.sh

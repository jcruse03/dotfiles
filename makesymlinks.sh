#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files="bashrc bash_prompt bash_profile tmux.conf vimrc aliases config/i3/config Xdefaults Xresources scripts/i3cmds/ddspawn scripts/i3cmds/tmuxdd i3blocks.conf inputrc scripts/lpass-menu"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# handle directory for qutebrowser, this can be done better for directories
echo "Moving .config/qutebrowser/ to $olddir"
mv ~/.config/qutebrowser/ $olddir
echo "Creating symlink to dotfiles/config/qutebrowser/ in home directory."
# the best way to think about ln is create a link to first argument in second argument
ln -s $dir/config/qutebrowser ~/.config

# handle directory for ranger config
echo "Moving .config/ranger/ to $olddir"
mv ~/.config/ranger/ $olddir
echo "Creating symlink to dotfiles/config/ranger in ~/.config/ranger"
ln -s $dir/config/ranger ~/.config

# create symlink to pasta script fro urxvt, copy/paste script
sudo cp ~/dotfiles/pasta /usr/lib/urxvt/perl/pasta
sudo chmod +x /usr/lib/urxvt/perl/pasta
# create source.sh for reloading all
#rm mysource.sh
#for file in $files; do
#    echo source ~/.$file >> mysource.sh
#done
#echo "echo done" >> mysource.sh
#chmod 755 $dir/mysource.sh

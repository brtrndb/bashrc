#!/bin/bash

BASHRC=".bashrc";
BASHRC_FOLDER=".bashrc.d"

save_current () {
    if [ -f $HOME/$BASHRC ]; then
	echo "Saving previous $BASHRC.";
	cp -v $HOME/$BASHRC $HOME/$BASHRC.save_`date +"%Y%m%d%H%M%S"`;
    else
	echo "No $BASHRC found in $HOME. Creating new one.";
	cp -v $BASHRC $HOME/$BASHRC;
    fi
}

copy_files () {
    echo "Copying files from $BASHRC_FOLDER into $HOME/$BASHRC_FOLDER.";
    cp -rv $BASHRC_FOLDER $HOME;
}

update_current () {
    echo "Updating current $BASHRC.";
    echo "" >> $HOME/$BASHRC;
    echo "# Custom part." >> $HOME/$BASHRC;
    echo ". $BASHRC.d/init.sh" >> $HOME/$BASHRC;
}

finish () {
    echo "You need to reload your current terminal."
}

run () {
    copy_files;
    if [ "$1" = "-i" ]; then
	save_current;
	update_current;
    fi
    finish;
}

run $*;

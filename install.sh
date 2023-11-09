#!/bin/sh
# Bertrand B.

BASHRC=".bashrc";
BASHRC_D="bashrc.d";
HOME_BASHRC="$HOME/$BASHRC";
HOME_BASHRC_D="$HOME/.$BASHRC_D";

usage () {
  echo "Usage: $(basename "$0") [OPTIONS]";
  echo "Options:";
  echo "  -s, --symlink: Install as symbolic link.";
  echo "  -c, --copy:    Install as copy.";
  echo "  -u, --update:  Update files in $HOME_BASHRC_D.";
  echo "  -r, --restore: Rollback to previous $BASHRC.";
  echo "  -h, --help:    Display usage."
}

symlink_files () {
  echo "Create symbolic links of $BASHRC_D into $HOME_BASHRC_D.";
  ln -s "$BASHRC_D" "$HOME_BASHRC_D";
}

copy_files () {
  echo "Copying files from $BASHRC_D into $HOME_BASHRC_D.";
  cp -rv "$BASHRC_D" "$HOME";
}

delete_files (){
  if [[ -d "$HOME_BASHRC_D" ]]; then
    echo "Deleting files from $HOME_BASHRC_D.";
    rm -vrf "$HOME_BASHRC_D";
  fi
}

backup_current_bashrc () {
  if [[ -f "$HOME_BASHRC" ]]; then
    echo "Saving previous $BASHRC.";
    cp -v "$HOME_BASHRC" "$HOME_BASHRC.save_$(date +"%Y%m%d%H%M%S")";
  else
    echo "No $BASHRC found in $HOME. Creating new one.";
    cp -v "$BASHRC" "$HOME_BASHRC";
  fi
}

update_current_bashrc () {
  echo "Updating current $BASHRC.";
  { echo "" ; echo "# Custom part." ; echo ". $HOME_BASHRC_D/init.sh"; } >> "$HOME_BASHRC";
}

restore_previous_bashrc () {
  LAST=$(find "$HOME" -maxdepth 1 -name ${BASHRC}.save* -print0  | xargs -0 ls -1 -t | head -1);
  if [[ -f "$LAST" ]]; then
    echo "Most recent save is: $LAST.";
    cp -vf "$LAST" "$HOME_BASHRC";
    echo "Current $HOME_BASHRC replaced by $LAST.";
  else
    echo "There is no previous .bashrc.";
  fi
}

finalize () {
  echo "You may need to reload your current terminal.";
}

run () {
  case "$1" in
    -s | --symbolic-link)
      backup_current_bashrc;
      symlink_files;
      update_current_bashrc;
      finalize;
      ;;
    -c | --copy)
      backup_current_bashrc;
      copy_files;
      update_current_bashrc;
      finalize;
      ;;
    -u | --update)
      delete_files;
      copy_files;
      finalize;
      ;;
    -r | --restore)
      delete_files;
      restore_previous_bashrc;
      finalize;
      ;;
    -h | --help)
      usage;
      ;;
    *)
      usage;
      ;;
  esac
}

run "$*";

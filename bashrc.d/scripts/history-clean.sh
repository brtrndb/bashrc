#!/bin/sh
# Bertrand B.

usage() {
  echo "Empty your command line history and delete your .bash_history.";
  echo "";
  echo "Usage: $(basename "$0") [OPTIONS]";
  echo "  -h, --help: Display usage.";
}

history_clean() {
  rm -f "$HOME/.bash_history" && clear && history -c;
}

run() {
  if [ $# -ge 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    usage;
    return;
  fi

  history_clean;
}

run "$*";

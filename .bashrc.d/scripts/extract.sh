#!/bin/sh
# Bertrand B.

usage() {
  echo "Extract archived file with correct command depending on file extension."
  echo "";
  echo "Usage: $(basename "$0") [OPTIONS] file";
  echo "Options:";
  echo "  -h, --help: Display usage.";
}

extract() {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar)      tar xf "$1" ;;
      *.tar.bz2)  tar xjf "$1" ;;
      *.tar.gz)   tar xzf "$1" ;;
      *.bz2)      bunzip2 "$1" ;;
      *.gz)       gunzip "$1" ;;
      *.rar)      rar x "$1" ;;
      *.tbz2)     tar xjf "$1" ;;
      *.tgz)      tar xzf "$1" ;;
      *.zip)      unzip "$1" ;;
      *.Z)        uncompress "$1" ;;
      *)          echo "'$1': Unknown file format." ;;
    esac
  else
    echo "'$1' is not a valid file";
  fi
}

run() {
  if [ $# -lt 1 ] || [ $# -gt 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    usage;
    return;
  fi

  extract "$*";
}

run "$*";

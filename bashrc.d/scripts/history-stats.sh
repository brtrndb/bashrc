#!/bin/sh
# Bertrand B.

HISTORY_FILE="$HOME/.bash_history";
DEFAULT_TOP_HISTORY_SIZE=30;

usage() {
  echo "Display your most used commands.";
  echo "";
  echo "Usage: $(basename "$0") [OPTIONS]";
  echo "  -h, --help: Display usage.";
}

history_stats() {
  if [ -f "$HISTORY_FILE" ]; then
    cut -f1 -d" " "$HISTORY_FILE" \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -n $1;
  else
    history \
    | sed -e "s/^[[:space:]]*[0-9]*[[:space:]]*//" \
    | cut -f1 -d" " \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -n $1;
  fi
}

run() {
  if [ $# -ge 2 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    usage;
    return;
  fi

  if [ $# -eq 1 ]; then
    if [ "$1" -eq "$1" ] 2>/dev/null; then
      history_stats "$1";
    else
      echo "Parameter must be a valid positive integer.";
    fi
    return;
  fi

  history_stats $DEFAULT_TOP_HISTORY_SIZE;
}

run $*;

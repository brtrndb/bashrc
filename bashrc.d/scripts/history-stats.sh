#!/bin/sh
# Bertrand B.

HISTORY_FILE="$HOME/.bash_history";
HISTORY_NB_STATS=30;

usage() {
  echo "Show you most used command from .bash_history.";
  echo "";
  echo "Usage: $(basename "$0") [OPTIONS]";
  echo "  -h, --help: Display usage.";
}

history_stats() {
  if [ -f "$HISTORY_FILE" ]; then
    cut -f1 -d" " "$HISTORY_FILE" | sort | uniq -c | sort -nr | head -n $HISTORY_NB_STATS;
  else
    history | sed -e "s/^[[:space:]]*[0-9]*[[:space:]]*//" | cut -f1 -d" " | sort | uniq -c | sort -nr | head -n $HISTORY_NB_STATS;
  fi
}

run() {
  if [ $# -ge 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    usage;
    return;
  fi

  history_stats;
}

run "$*";

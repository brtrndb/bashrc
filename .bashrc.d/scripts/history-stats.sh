#!/bin/sh
# Bertrand B.

HISTORY_FILE=$HOME/.bash_history;

if [ -f "$H" ]; then
    cut -f1 -d" " $HISTORY_FILE | sort | uniq -c | sort -nr | head -n 30;
else
    history | sed -e "s/^[[:space:]]*[0-9]*[[:space:]]*//" | cut -f1 -d" " | sort | uniq -c | sort -nr | head -n 30;
fi

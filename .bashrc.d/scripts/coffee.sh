#!/bin/sh
# Bertrand B.

usage() {
  echo "Because you need coffee ☕."
  echo "";
  echo "Usage: $(basename "$0") [OPTIONS]";
  echo "Options:";
  echo "  -h, --help: Display usage.";
}

coffee() {
  hexdump -C < /dev/urandom | grep --color=auto "ca fe";
}

run() {
  if [ $# -ge 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    usage;
    return;
  fi

  coffee;
}

run "$*";

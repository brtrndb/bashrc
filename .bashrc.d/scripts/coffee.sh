#!/bin/sh
# Bertrand B.

usage () {
    echo "Usage: $(basename "$0") { -h }"
    echo "-h, --help: Display usage.";
}

configure() {
    while [ "$#" -gt "0" ]; do
	case "$1" in
	    -h | --help)
		usage;
		exit 0;
		;;
	    -* | --*)
		echo "Unknown option: $1. Ignored."
		shift 1;
		;;
	esac
    done
}

coffee() {
    cat /dev/urandom | hexdump -C | grep --color=auto "ca fe";
}

run() {
    configure $*;
    coffee;
}

run $*;

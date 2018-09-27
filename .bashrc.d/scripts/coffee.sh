#!/bin/sh
# Bertrand B.

cat /dev/urandom | hexdump -C | grep --color=auto "ca fe";
